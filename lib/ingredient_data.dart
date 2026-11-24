
class CosmeticIngredient {
  final String inciName;
  final List<String> commonNames;
  final String category;
  final String description;
  final List<String> functions;
  final String benefits;
  final String possibleConcerns;
  final String precautions;
  final List<String> sources;

  const CosmeticIngredient({
    required this.inciName,
    required this.commonNames,
    required this.category,
    required this.description,
    required this.functions,
    required this.benefits,
    required this.possibleConcerns,
    required this.precautions,
    required this.sources,
  });
}

const List<CosmeticIngredient> cosmeticIngredients = [

  CosmeticIngredient(
    inciName: 'Aqua',
    commonNames: ['Water'],
    category: 'Basic ingredient',
    description: 'Water used as a base in many cosmetic formulations.',
    functions: ['Solvent'],
    benefits: 'Helps dissolve and distribute water-soluble ingredients.',
    possibleConcerns: 'No specific concern is generally associated with cosmetic-grade water itself.',
    precautions: 'The quality and microbiological safety of water in a formulation matter.',
    sources: ['COSMILE Europe', 'European Commission CosIng'],
  ),

  CosmeticIngredient(
    inciName: 'Glycerin',
    commonNames: ['Glycerol'],
    category: 'Humectant',
    description: 'A water-attracting ingredient used in skincare and haircare.',
    functions: ['Humectant', 'Skin conditioning', 'Hair conditioning'],
    benefits: 'Helps attract and retain moisture.',
    possibleConcerns: 'Generally well tolerated, although irritation can occur in some formulations or individuals.',
    precautions: 'Its effect depends on the complete formulation.',
    sources: ['COSMILE Europe', 'Cosmetic Ingredient Review'],
  ),

  CosmeticIngredient(
    inciName: 'Sodium Hyaluronate',
    commonNames: ['Hyaluronic Acid salt'],
    category: 'Humectant',
    description: 'A sodium salt of hyaluronic acid used in cosmetic moisturising products.',
    functions: ['Humectant', 'Skin conditioning'],
    benefits: 'Helps maintain skin hydration.',
    possibleConcerns: 'Sensitivity or irritation may occur, although it is generally well tolerated.',
    precautions: 'Different molecular forms can have different formulation properties.',
    sources: ['COSMILE Europe', 'PubChem'],
  ),

  CosmeticIngredient(
    inciName: 'Niacinamide',
    commonNames: ['Nicotinamide', 'Vitamin B3'],
    category: 'Skin conditioning',
    description: 'A form of vitamin B3 used in skincare formulations.',
    functions: ['Skin conditioning'],
    benefits: 'Supports skin barrier function and helps improve the appearance of uneven skin tone.',
    possibleConcerns: 'Some individuals may experience redness, itching or irritation.',
    precautions: 'Individual tolerance and the complete formulation matter.',
    sources: ['COSMILE Europe', 'PubChem'],
  ),

  CosmeticIngredient(
    inciName: 'Panthenol',
    commonNames: ['Provitamin B5', 'D-Panthenol'],
    category: 'Skin and hair conditioning',
    description: 'A vitamin B5-related ingredient used in skincare and haircare.',
    functions: ['Humectant', 'Skin conditioning', 'Hair conditioning'],
    benefits: 'Helps moisturise and condition skin and hair.',
    possibleConcerns: 'Sensitivity or contact reactions are possible but uncommon.',
    precautions: 'Check the complete product formulation when evaluating reactions.',
    sources: ['COSMILE Europe', 'PubChem'],
  ),

  CosmeticIngredient(
    inciName: 'Tocopherol',
    commonNames: ['Vitamin E'],
    category: 'Antioxidant',
    description: 'A form of vitamin E used in cosmetic formulations.',
    functions: ['Antioxidant', 'Skin conditioning'],
    benefits: 'Provides antioxidant activity and helps protect oils in formulations from oxidation.',
    possibleConcerns: 'Contact sensitivity can occur in some individuals.',
    precautions: 'Do not assume every vitamin E derivative has identical properties.',
    sources: ['COSMILE Europe', 'Cosmetic Ingredient Review'],
  ),

  CosmeticIngredient(
    inciName: 'Ascorbic Acid',
    commonNames: ['Vitamin C'],
    category: 'Antioxidant',
    description: 'A form of vitamin C used in cosmetic formulations.',
    functions: ['Antioxidant', 'Skin conditioning'],
    benefits: 'Provides antioxidant activity and is used in products targeting the appearance of uneven skin tone.',
    possibleConcerns: 'Some formulations can cause stinging, redness or irritation.',
    precautions: 'Formulation stability and pH influence its properties.',
    sources: ['COSMILE Europe', 'PubChem'],
  ),

  CosmeticIngredient(
    inciName: 'Salicylic Acid',
    commonNames: ['BHA'],
    category: 'Exfoliant',
    description: 'A beta hydroxy acid used in certain cosmetic formulations.',
    functions: ['Exfoliating', 'Skin conditioning'],
    benefits: 'Helps exfoliate the skin and is used in products targeting clogged pores.',
    possibleConcerns: 'Can cause dryness, irritation and sensitivity.',
    precautions: 'Its permitted uses and conditions depend on applicable cosmetic regulations.',
    sources: ['COSMILE Europe', 'European Commission CosIng'],
  ),

  CosmeticIngredient(
    inciName: 'Glycolic Acid',
    commonNames: ['Alpha Hydroxy Acid', 'AHA'],
    category: 'Exfoliant',
    description: 'An alpha hydroxy acid used in cosmetic exfoliating formulations.',
    functions: ['Exfoliating', 'Skin conditioning'],
    benefits: 'Helps remove surface dead skin cells.',
    possibleConcerns: 'May cause irritation and increased sensitivity to sunlight.',
    precautions: 'Formulation pH and concentration influence its effects.',
    sources: ['COSMILE Europe', 'Cosmetic Ingredient Review'],
  ),

  CosmeticIngredient(
    inciName: 'Lactic Acid',
    commonNames: ['Alpha Hydroxy Acid'],
    category: 'Exfoliant and humectant',
    description: 'An alpha hydroxy acid used in cosmetic formulations.',
    functions: ['Exfoliating', 'Humectant', 'pH adjuster'],
    benefits: 'Can help exfoliate the skin and support moisture retention.',
    possibleConcerns: 'May cause irritation and increased sensitivity to sunlight.',
    precautions: 'Its function depends on the formulation and concentration.',
    sources: ['COSMILE Europe', 'European Commission CosIng'],
  ),

  CosmeticIngredient(
    inciName: 'Ceramide NP',
    commonNames: ['Ceramide 3'],
    category: 'Skin conditioning',
    description: 'A lipid used in skincare formulations to support the skin barrier.',
    functions: ['Skin conditioning'],
    benefits: 'Helps support the skin barrier and reduce moisture loss.',
    possibleConcerns: 'The complete formulation may cause reactions in sensitive individuals.',
    precautions: 'Ceramides are a family of related lipid ingredients.',
    sources: ['COSMILE Europe', 'PubChem'],
  ),

  CosmeticIngredient(
    inciName: 'Squalane',
    commonNames: ['Squalane oil'],
    category: 'Emollient',
    description: 'An oil-like ingredient used to soften and condition skin.',
    functions: ['Emollient', 'Skin conditioning'],
    benefits: 'Helps soften skin and reduce moisture loss.',
    possibleConcerns: 'Individual sensitivity to a complete product is possible.',
    precautions: 'Squalane and squalene are different substances.',
    sources: ['COSMILE Europe', 'PubChem'],
  ),

  CosmeticIngredient(
    inciName: 'Phenoxyethanol',
    commonNames: [],
    category: 'Preservative',
    description: 'A preservative used to help control microbial growth in cosmetics.',
    functions: ['Preservative', 'Antimicrobial'],
    benefits: 'Helps protect cosmetic formulations from microbial contamination.',
    possibleConcerns: 'May cause irritation or contact reactions in some individuals.',
    precautions: 'Regulatory limits vary by jurisdiction. The EU permits its use up to 1% in cosmetics.',
    sources: ['European Commission CosIng', 'Cosmetic Ingredient Review'],
  ),

  CosmeticIngredient(
    inciName: 'Parfum',
    commonNames: ['Fragrance', 'Perfume'],
    category: 'Fragrance',
    description: 'A label term used for fragrance compositions in cosmetic products.',
    functions: ['Perfuming'],
    benefits: 'Provides a scent to cosmetic products.',
    possibleConcerns: 'Some fragrance components can cause allergic contact reactions or irritation.',
    precautions: 'The word Parfum does not identify every individual fragrance component.',
    sources: ['COSMILE Europe', 'European Commission CosIng'],
  ),

  CosmeticIngredient(
    inciName: 'Zinc Oxide',
    commonNames: ['ZnO'],
    category: 'UV filter and colourant',
    description: 'An inorganic mineral ingredient used in cosmetic products.',
    functions: ['UV filter', 'Colourant', 'Skin protectant'],
    benefits: 'Used in sunscreen formulations to help protect against ultraviolet radiation.',
    possibleConcerns: 'The complete formulation and application format influence exposure and tolerability.',
    precautions: 'Regulatory conditions depend on the product type and jurisdiction.',
    sources: ['European Commission CosIng', 'COSMILE Europe'],
  ),

];