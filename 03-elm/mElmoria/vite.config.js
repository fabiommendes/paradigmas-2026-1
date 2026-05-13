import { defineConfig } from "vite";

import elmPlugin from 'vite-plugin-elm'
import tailwindcss from '@tailwindcss/vite'

export default defineConfig({
  plugins: [
    tailwindcss(),
    elmPlugin(),
  ],
});
