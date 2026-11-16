# Homebrew tap de Esfinge

**Esfinge** cifra y descifra contraseñas y ficheros con una clave, con ventana propia y línea de
comandos. De [Webcafeína](https://webcafeina.com).

```sh
# La aplicación, con su ventana (macOS)
brew install --cask webcafeina/esfinge/esfinge

# La línea de comandos, para tuberías y guiones (macOS y Linux)
brew install webcafeina/esfinge/esfinge
```

## Qué hay aquí, y qué no

Dos recetas y nada más: `Casks/esfinge.rb` instala la aplicación desde la imagen de disco oficial,
y `Formula/esfinge.rb` la línea de comandos. **Las dos las escribe el propio proyecto y las
actualiza su flujo de publicación**, con las sumas SHA-256 de cada versión; no se editan a mano.

Lo que se instala es **el fichero oficial de la publicación de GitHub**, sin modificar y con su
suma comprobada. El código de Esfinge no está aquí: vive en
[webcafeina/esfinge](https://github.com/webcafeina/esfinge).

## Dos cosas que conviene saber

- **Esfinge no está firmada ni notarizada** por Apple, y es una decisión tomada. El cask le quita
  la cuarentena al instalar, que es lo que hace que la aplicación abra; sin eso macOS la bloquearía.
- **Esfinge se actualiza sola** en macOS, desde la propia aplicación. Por eso el cask lleva
  `auto_updates true`: Homebrew no tiene que actualizarla, y si lo intentara se pisarían.
- **Desinstalar no borra la bóveda.** El `zap` se lleva cachés y estado del webview; tus
  contraseñas se quedan donde están. Si quieres irte del todo, bórralas tú.

## Licencia

Las recetas son parte de Esfinge y están cubiertas por
[su licencia](https://github.com/webcafeina/esfinge/blob/main/LICENSE), que desde el 2026-11-16
permite expresamente recetas como éstas: bajar el programa de la publicación oficial e instalarlo
**sin modificarlo**.
