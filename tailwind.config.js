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
        'cherry-pink': '#FFB7C5',
        correct: '#569932',
        wrong: '#a1282b'
      },
      backgroundImage: {
        'flag-pattern': "url('/flag.svg')"
      },
      animation: {
        'hop': 'hop 750ms ease-in-out',
        'wiggle': 'wiggle 750ms ease-in-out',
        'zoom': 'zoom 650ms ease-in-out',
      },
      keyframes: {
        hop: {
          '0%, 100%': { transform: 'translateY(0)' },
          '60%': { transform: 'translateY(-25%)' },
        },
        wiggle: {
          '0%, 20%, 50%, 80%, 100%': { transform: 'translateY(0)' },
          '10%, 40%, 70%': { transform: 'translateX(-10%)' },
          '30%, 60%, 90%': { transform: 'translateX(10%)' },
        },
        zoom: {
          '0%, 100%': { transform: 'scale(100%)' },
          '50%': { transform: 'scale(110%)' },
        }
      }
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
