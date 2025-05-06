module.exports = {
  prompt: ({ inquirer }) => {
    return inquirer
      .prompt([
        {
          type: "input",
          name: "name",
          message: "Screen name (e.g., Home):",
        },
      ])
      .then((answers) => {
        const { name } = answers;

        // Convert "Home" -> "home"
        const camelName = name.charAt(0).toLowerCase() + name.slice(1);

        // Convert "HomeScreen" -> "home_screen"
        const snakeName = name.replace(
          /[A-Z]/g,
          (match, i) => (i === 0 ? "" : "_") + match.toLowerCase()
        );

        // Convert "Home" -> "HomeScreen"
        const screenName = name.endsWith("Screen") ? name : `${name}Screen`;

        return {
          ...answers,
          camelName,
          snakeName,
          screenName,
        };
      });
  },
};
