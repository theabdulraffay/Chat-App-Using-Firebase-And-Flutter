module.exports = {
  prompt: ({ inquirer }) =>
    inquirer.prompt([
      {
        type: 'input',
        name: 'name',
        message: 'What is the name of the BLoC?',
      },
    ]).then((answers) => {
      const name = answers.name;
      const proper = name.charAt(0).toUpperCase() + name.slice(1);
      const lower = name.charAt(0).toLowerCase() + name.slice(1);

      return {
        ...answers,
        proper,
        lower,
      };
    }),
};
