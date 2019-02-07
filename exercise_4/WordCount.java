package mocc;

import java.util.*;

import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.api.common.functions.FlatMapFunction;
import org.apache.flink.api.common.functions.ReduceFunction;
import org.apache.flink.api.java.utils.ParameterTool;
import org.apache.flink.streaming.api.datastream.DataStream;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.streaming.api.windowing.time.Time;
import org.apache.flink.util.Collector;
import org.apache.flink.core.fs.FileSystem;

@SuppressWarnings("serial")
public class WordCount {

	public static void main(String[] args) throws Exception {

		final String inputPath;
		final String outputPath;
		try {
			final ParameterTool params = ParameterTool.fromArgs(args);
			inputPath = params.get("input");
			outputPath = params.get("output");
		} catch (Exception e) {
			System.err.println("Please run 'wordcount --input <input> --output <output>");
			return;
		}

		final StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();

		DataStream<String> text = env.readTextFile(inputPath);

		DataStream<WordWithCount> windowCounts = text

				.flatMap(new FlatMapFunction<String, WordWithCount>() {
					@Override
					public void flatMap(String value, Collector<WordWithCount> out) {
						for (String word : WordCount.filter(value)) {
							out.collect(new WordWithCount(word, 1L));
						}
					}
				})

				.keyBy("word")
				.reduce(new ReduceFunction<WordWithCount>() {
					@Override
					public WordWithCount reduce(WordWithCount a, WordWithCount b) {
						return new WordWithCount(a.word, a.count + b.count);
					}
				});

		windowCounts.writeAsCsv(outputPath, FileSystem.WriteMode.OVERWRITE).setParallelism(1);

		env.execute("Mocc WordCount");
	}

    private static String[] filter(String value) {
    	List<String> words = new ArrayList<String>();

    	for(String rawValue : value.split("\\s")) {
    		String word = rawValue.toLowerCase();
    		word = word.replaceAll("[^A-Za-z0-9']", "");
    		if("".equals(word))
    			continue;

    		words.add(word);
    	}

    	String[] data = new String[words.size()];
    	words.toArray(data);
		return data;
	}

	// ------------------------------------------------------------------------

	/**
	 * Data type for words with count.
	 */
	public static class WordWithCount {

		public String word;
		public long count;

		public WordWithCount() {}

		public WordWithCount(String word, long count) {
			this.word = word;
			this.count = count;
		}

		@Override
		public String toString() {
			return word + ", " + count;
		}
}
}
