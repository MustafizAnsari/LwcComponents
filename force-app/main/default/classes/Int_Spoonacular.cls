public class Int_Spoonacular 
{
    @AuraEnabled
    Public static String GetRandomRecipe()
    {
        String endPoint ='https://api.spoonacular.com/recipes/random?apiKey=589be479bc884f3cb98598b7676f4605';
        Http ht = New Http();
        HttpRequest request = New HttpRequest();
        request.SetEndPoint(endPoint);
        request.SetMethod('GET');
        
        HttpResponse res = ht.Send(request);
        if(res.getStatusCode() == 200)
        {
            return res.getBody();
        }     
        return '';
    }
    
    
     @AuraEnabled
    Public static String GetRecipe(String recipeId)
    {
        String endPoint ='https://api.spoonacular.com/recipes/'+recipeId+'/information?apiKey=589be479bc884f3cb98598b7676f4605';
        Http ht = New Http();
        HttpRequest request = New HttpRequest();
        request.SetEndPoint(endPoint);
        request.SetMethod('GET');
        
        HttpResponse res = ht.Send(request);
        if(res.getStatusCode() == 200)
        {
            return res.getBody();
        }     
        return '';  
    }
    
     @AuraEnabled
    Public static String GetRecipeByIngredient(string ingredients)
    {
        String endPoint ='https://api.spoonacular.com/recipes/findByIngredients?apiKey=589be479bc884f3cb98598b7676f4605&ingredients='+ingredients;
        Http ht = New Http();
        HttpRequest request = New HttpRequest();
        request.SetEndPoint(endPoint);
        request.SetMethod('GET');
        
        HttpResponse res = ht.Send(request);
        if(res.getStatusCode() == 200)
        {
            return res.getBody();
        }     
        return '';  
    }
}