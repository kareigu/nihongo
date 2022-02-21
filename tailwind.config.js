module.exports = {
  mode: 'jit',
  content: [
    './src/**/*.elm'
  ],
  darkMode: 'media', // or 'media' or 'class'
  theme: {
    extend: {
      fontFamily: {
        'Kosugi': ['Kosugi', 'sans-serif'],
        'PT-Sans': ['PT Sans', 'sans-serif'],
        'Shippori': ['Shippori Antique', 'sans-serif']
      },
      colors: {
        auburn: '#A31E20',
        platinum: '#DEE0DB',
        'raisin-black': '#232020',
        'mountbatten-pink': '#9C7A97',
        'cherry-pink': '#FFB7C5'
      }
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
