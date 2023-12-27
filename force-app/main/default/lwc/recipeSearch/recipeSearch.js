import { LightningElement } from 'lwc';
import GetRandomRecipe from '@salesforce/apex/Int_Spoonacular.GetRandomRecipe';
import GetRecipeByIngredient from '@salesforce/apex/Int_Spoonacular.GetRecipeByIngredient';

export default class RecipeSearch extends LightningElement 
{
    recipes = [];

     fatchRandomRecipe(){
        GetRandomRecipe()
        .then((data) => {
         this.recipes =
               JSON.parse(data) && JSON.parse(data).recipes  
            ? JSON.parse(data).recipes
            : [] 
        })
        .catch((error) => {
             console.error(error);
        });    
     }

     fetchRecipeByIngredient(){
        const ingredients = this.template.querySelector(".ingredient-input").value;
        GetRecipeByIngredient( {ingredients })
        .then((data) =>{
               this.recipes = JSON.parse(data);
        })
        .catch((error) =>{
             console.error(error);
        })
     }
}