const quote = (file) => `"${file.replaceAll('"', '\\"')}"`;

module.exports = {
  "cars_manager/{lib,test}/**/*.dart": (files) => {
    // Process files in smaller batches to avoid command line length limits
    const batchSize = 10;
    const batches = [];

    for (let i = 0; i < files.length; i += batchSize) {
      const batch = files.slice(i, i + batchSize);
      batches.push(`dart format ${batch.map(quote).join(" ")}`);
    }

    return batches;
  },
};
