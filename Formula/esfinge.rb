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
  version "2.67.0"
  license :cannot_represent

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/webcafeina/esfinge/releases/download/v2.67.0/esfinge-2.67.0-darwin-arm64"
      sha256 "0dc5bf01199f5bb8a7bb98b563ee4f073ec8842f769ad27964abcd5221ef80ea"
    end
    on_intel do
      url "https://github.com/webcafeina/esfinge/releases/download/v2.67.0/esfinge-2.67.0-darwin-amd64"
      sha256 "1aa3498b540ded80fc23dcf5ffcff0f6cf28e55875dd98c9873ad115bc46e8b2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/webcafeina/esfinge/releases/download/v2.67.0/esfinge-2.67.0-linux-arm64"
      sha256 "1e5626bfaaf26197f68c01b601d862dfadf62c8070dfb535db9768cbfc6d103f"
    end
    on_intel do
      url "https://github.com/webcafeina/esfinge/releases/download/v2.67.0/esfinge-2.67.0-linux-amd64"
      sha256 "117132aadaf1655d4e55336ed69bf4e89d4972f2310bdb9f6de1e2037d591513"
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
