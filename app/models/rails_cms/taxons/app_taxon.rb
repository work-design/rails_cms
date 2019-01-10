class AppTaxon < Taxon
  has_many :apps, -> { verified }, dependent: :nullify

end
