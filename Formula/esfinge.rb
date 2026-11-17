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
  version "2.68.0"
  license :cannot_represent

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/webcafeina/esfinge/releases/download/v2.68.0/esfinge-2.68.0-darwin-arm64"
      sha256 "8572df06de13ca48f8c47fd91a794008eab8f7b126fecd79777b5499a03ac19c"
    end
    on_intel do
      url "https://github.com/webcafeina/esfinge/releases/download/v2.68.0/esfinge-2.68.0-darwin-amd64"
      sha256 "9a4f002781eb43baa8b97905ad0d50e5a5ca2d790de389af34b225d32ce1469d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/webcafeina/esfinge/releases/download/v2.68.0/esfinge-2.68.0-linux-arm64"
      sha256 "feaf19311e35dfc9ac3beac3e65f88010765289363002c293ce75a7947e56a7d"
    end
    on_intel do
      url "https://github.com/webcafeina/esfinge/releases/download/v2.68.0/esfinge-2.68.0-linux-amd64"
      sha256 "911b9c43443e90ae85f35d23a18de49dd79700cc36ce11b630cae76c2312e299"
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
