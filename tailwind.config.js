module.exports = {
  mode: 'jit',
  content: [
    './src/**/*.elm',
    './public/index.html'
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
        'wave-pattern': "url('/bg_banner.webp')",
        "flag-pattern": "url('/flag.svg')"
      },
      animation: {
        'hop': 'hop 750ms ease-in-out',
        'wiggle': 'wiggle 750ms ease-in-out',
        'zoom': 'zoom 650ms ease-in-out',
        'drop': 'drop 250ms ease-in',
        'drop-slow': 'drop 350ms ease-in',
        'drop-slowest': 'drop 450ms ease-in',
        'slide-in-right': 'slide-in-right 350ms ease-in-out',
        'flip': 'flip 250ms ease-in-out',
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
        },
        drop: {
          '0%': { 
            transform: 'translateY(-25%)',
            opacity: '0',
          },
          '50%': { 
            transform: 'translateY(-12.5%)',
            opacity: '1',
          },
          '100%': { 
            transform: 'translateY(0)',
            opacity: '1',
          },
        },
        'slide-in-right': {
          '0%': { 
            transform: 'translateX(-25%)',
            opacity: '0',
          },
          '50%': { 
            transform: 'translateX(-15%)',
            opacity: '1',
          },
          '70%': { 
            transform: 'translateX(5%)',
            opacity: '1',
          },
          '100%': { 
            transform: 'translateX(0)',
            opacity: '1',
          }
        },
        flip: {
          '0%': { 
            transform: 'rotateY(0deg) scale(100%)',
            opacity: '0',
          },
          '50%': { 
            transform: 'rotateY(180deg) scale(120%)',
            opacity: '1',
          },
          '100%': { 
            transform: 'rotateY(360deg) scale(100%)',
            opacity: '1',
          }
        }
      }
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
