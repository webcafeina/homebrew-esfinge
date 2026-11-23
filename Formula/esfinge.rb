# Plantilla de la fórmula de Esfinge. `canales.yml` la rellena en cada versión y la empuja a
# webcafeina/homebrew-esfinge como Formula/esfinge.rb.
#
# **Esto es la línea de comandos, no la aplicación.** La ventana va en el cask de al lado
# (esfinge-cask.rb), que es lo que quiere quien usa un Mac de escritorio; esta fórmula es para
# tuberías y guiones, y sirve también en Linux.
#
# Son binarios ya compilados, uno por objetivo, y en un tap propio eso es lo normal: `brew style`
# lo marca porque es una regla del repositorio oficial, que compila desde el código. Y una fórmula
# **no se pone en cuarentena**, así que macOS no bloquea el binario aunque Esfinge no esté firmada
# (ADR 0012) — al contrario que el cask, que sí necesita quitarla.
#
# Lo que **no** instala: `esfinge-mcp` y `esfinge-puente`. El primero solo traduce para un agente y
# necesita la ventana abierta para llegar a la bóveda; el segundo lo lanza el navegador por un
# manifiesto que instala la aplicación. Sin ventana no hacen nada, así que ponerlos en el PATH sería
# ofrecer dos órdenes que no pueden funcionar.
class Esfinge < Formula
  desc "Cifra y descifra contraseñas y ficheros con una clave"
  homepage "https://esfinge.webcafeina.com/"
  version "2.78.0"
  license :cannot_represent

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/webcafeina/esfinge/releases/download/v2.78.0/esfinge-2.78.0-darwin-arm64"
      sha256 "5e32e743ad3fdeb89411d5c0c79fb8d33b7bc06dc629ad172154ca0e1cd6d51b"
    end
    on_intel do
      url "https://github.com/webcafeina/esfinge/releases/download/v2.78.0/esfinge-2.78.0-darwin-amd64"
      sha256 "e6b0a786f8d73c3cd9af4d71923159ed98c680ba6fdd4f85e6ca3b4fafb11a4e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/webcafeina/esfinge/releases/download/v2.78.0/esfinge-2.78.0-linux-arm64"
      sha256 "f3ded88447b0ec25d28309ab8310e7f3a73afa501ee113f30af7dd1c941d1a39"
    end
    on_intel do
      url "https://github.com/webcafeina/esfinge/releases/download/v2.78.0/esfinge-2.78.0-linux-amd64"
      sha256 "2f4894d20b476251d78649ba6bbe3b3f87eb176ca3e70c4b1f6c45b3902fb48b"
    end
  end

  def install
    # Lo que se descarga es **el binario pelado**, no un paquete: llega con el nombre de su
    # objetivo —esfinge-2.65.3-darwin-arm64— y hay que renombrarlo al instalarlo, porque lo que la
    # gente escribe es «esfinge».
    bin.install Dir["esfinge-*"].first => "esfinge"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/esfinge --version")
  end
end
