import Reveal from 'reveal.js';
import Markdown from 'reveal.js/plugin/markdown/markdown';
import Notes from 'reveal.js/plugin/notes/notes';
import Highlight from 'reveal.js/plugin/highlight/highlight';

document.addEventListener('DOMContentLoaded', () => {
  const markdownLink = document.querySelector('link[data-markdown]');
  const markdownContainer = document.querySelector('.reveal .slides section[data-markdown]');
  markdownContainer.dataset.markdown = markdownLink.href;

  const deck = new Reveal({
    plugins: [
      Markdown,
      Notes,
      Highlight,
    ],
    progress: false,
    navigationMode: 'linear',
    hash: true,
  });

  deck.initialize();
});
