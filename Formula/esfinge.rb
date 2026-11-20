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
  version "2.72.1"
  license :cannot_represent

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/webcafeina/esfinge/releases/download/v2.72.1/esfinge-2.72.1-darwin-arm64"
      sha256 "62a8ef9ef3eecdbcc9e20b833eeaaa79b44c59cf0627acd826c956c92d52ba3a"
    end
    on_intel do
      url "https://github.com/webcafeina/esfinge/releases/download/v2.72.1/esfinge-2.72.1-darwin-amd64"
      sha256 "94699cfba5e790a2bfc1085c44ea1bcc03b8ee886d39b8802b6bfdd021ae4cd0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/webcafeina/esfinge/releases/download/v2.72.1/esfinge-2.72.1-linux-arm64"
      sha256 "62c1b76d6dd5565a4000f0c6fa059c7430adbb4bfcaa6066d41dad0aedb9b197"
    end
    on_intel do
      url "https://github.com/webcafeina/esfinge/releases/download/v2.72.1/esfinge-2.72.1-linux-amd64"
      sha256 "48954c74a5f1c3c4a360f281735b8a7bd3804090899337a4bba1ac555aa47b56"
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
