# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
Rails.application.config.assets.precompile += %w[
  aniversario.webp
  avatar.png
  BannerInicial.svg
  BannerLogin.svg
  Background\ -\ Login.svg
  bolos.jpeg
  casamento.jpg
  CastrilloEventos.png
  clock.svg
  coffebreak.jpeg
  decoracao4.jpg
  debutante.jpg
  doces.webp
  eventoLove.jpg
  imgDecoracaoBanner.jpg
  imgDecoracaoBanner2.jpg
  imgDecoracaoBanner3.jpg
  imgDecoracaoBanner4.jpg
  imgDecoracaoBanner5.jpg
  imgDecoracaoBanner6.jpg
  imgDecoracaoBanner7.jpg
  imgPerfil.png
  lanches.webp
  loading-gif.gif
  logoBranca.png
  Matriz\ \(1\).png
  Pencil.png
  piscina.jpg
  Salvagos.jpeg
  teste.jpeg
  VectorVoltar.svg
]
