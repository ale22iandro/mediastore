# encoding: utf-8
#
# Класс Фильм
class Disc < Product
  attr_accessor :album, :artist, :year, :genre

  # Метод класса from_file считывает данные о фильме из файла, путь к которому
  # ему передали в качестве параметра и передает их на вход своему же
  # конструктору с нужными ключами.
  def self.from_file(file_path)
    lines = File.readlines(file_path, encoding: 'UTF-8').map { |l| l.chomp }

    self.new(
      album: lines[0],
      artist: lines[1],
      genre: lines[2],
      year: lines[3],
      price: lines[4],
      amount: lines[5]
    )
  end

  def initialize(params)
    super

    @album = params[:album]
    @year = params[:year]
    @artist = params[:artist]
    @genre = params[:genre]
  end

  def to_s
    "Диск «#{@album}», #{@artist}, #{@genre}, (#{@year}), #{super}"
  end

  def update(params)
    super

    @album = params[:album] if params[:album]
    @year = params[:year] if params[:year]
    @artist = params[:artist] if params[:artist]
    @genre = params[:genre ] if params[:genre ]
  end
end
