class Endpoints {
  static String baseUrl = 'https://www.thecocktaildb.com/api/json/v1/1';

  static String getAlcoholicCocktails = '/filter.php?a=Alcoholic';

  static String getNonAlcoholicCocktails = '/filter.php?a=Non_Alcoholic';

  static String getCategories = '/list.php?c=list';

  static String getGlasses = '/list.php?g=list';

  static String getIngridients = '/list.php?i=list';

  static String getCocktailDetails = '/lookup.php';

  static String searchCocktailByName = '/search.php';

  static String getRandomCocktail = '/random.php';

  static String filterCocktail = '/filter.php';

  static String search = '/search.php';

}
