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
  version "2.77.0"
  license :cannot_represent

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/webcafeina/esfinge/releases/download/v2.77.0/esfinge-2.77.0-darwin-arm64"
      sha256 "4a964947e2eb8533f3409d531a9ec5d96f777bd8d93000caf814d78055b47c14"
    end
    on_intel do
      url "https://github.com/webcafeina/esfinge/releases/download/v2.77.0/esfinge-2.77.0-darwin-amd64"
      sha256 "7aaa58a8acd21154f8b2fdb90ea073d59bb19e489b0907d68ffbe9939179ac05"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/webcafeina/esfinge/releases/download/v2.77.0/esfinge-2.77.0-linux-arm64"
      sha256 "6b2cdf9a264fe372a7c17c422d8606d75f71af2627017cb142a1ac1329adae09"
    end
    on_intel do
      url "https://github.com/webcafeina/esfinge/releases/download/v2.77.0/esfinge-2.77.0-linux-amd64"
      sha256 "3d78e17089dfa009e52333541b1388d819a6797fbc1c55e6374fbda93532808c"
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
