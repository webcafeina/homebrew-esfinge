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
  version "2.72.0"
  license :cannot_represent

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/webcafeina/esfinge/releases/download/v2.72.0/esfinge-2.72.0-darwin-arm64"
      sha256 "c81e535351cfc395305307a8e9ffb458f8003e8da539bfe27cc85e8316d762e9"
    end
    on_intel do
      url "https://github.com/webcafeina/esfinge/releases/download/v2.72.0/esfinge-2.72.0-darwin-amd64"
      sha256 "95a91041b197cff831a6d6f830990d541ede30239e5b5114a34cbda0dbc28bf4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/webcafeina/esfinge/releases/download/v2.72.0/esfinge-2.72.0-linux-arm64"
      sha256 "1d34b17fa5de3f5fb7b0fca52bc0568cccc95604d5fa2ab3bbd192b5e489f6fb"
    end
    on_intel do
      url "https://github.com/webcafeina/esfinge/releases/download/v2.72.0/esfinge-2.72.0-linux-amd64"
      sha256 "ac58de7bffe0f5aba02776667e4e71bafa81138b2719b6fc68fadca75693d038"
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
