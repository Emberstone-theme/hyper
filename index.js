module.exports.decorateConfig = config => {
  return Object.assign({}, config, {
    cursorColor: 'rgba(216, 131, 73, 0.5)',
    cursorAccentColor: '#ECD2AB',
    foregroundColor: '#F8EDDC',
    backgroundColor: '#151722',
    selectionColor: 'rgba(200, 76, 83, 0.09999999999999998)',
    borderColor: '#D88349',
    colors: {
      black: '#00849A',
      lightBlack: '#8AD9E9',

      red: '#C84C53',
      lightRed: '#EDB7BF',
      
      green: '#9BBA51',
      lightGreen: '#C9E295',
      
      yellow: '#CAA53E',
      lightYellow: '#ECDA9C',
      
      blue: '#D88349',
      lightBlue: '#D88349',
      
      cyan: '#A17AB5',
      lightCyan: '#D7C0E4',
      
      magenta: '#7FA39F',
      lightMagenta: '#A8E7D2',
     
      white: '#F8EDDC',
      lightWhite: '#E3E3E3',
    },
  });
};