var id = 0;
var compteur = 0;
var limite = 5;
var dico = {}; 

function addInput(divName){
         if (compteur == limite)  {
              alert("Vous avez atteint la limite " + compteur + " des champs");
         }
         else {
              var newdiv = document.createElement('div');
              newdiv.innerHTML = "Nouvelle colonne  <br><input type='text' name='myColumns[]'>";
		sel="<select name=\"myFields[]\" id=\"myFields\">";
		sel+="<option value=\"INT\">int</option>";
		sel+="<option value=\"VARCHAR(100)\">varchar</option>";
		sel+="<option value=\"FLOAT\">float</option>";
		sel+="</select>";

		//but="<button type='button' onClick='buttonClick('"+str(compteur)+")'>Supprimer le champ</button>";
		but="<button type='button' onClick='buttonClick("+(id)+")'>Supprimer le champ</button>";

              newdiv.innerHTML +=sel+but;
              document.getElementById(divName).appendChild(newdiv);
		dico[id]=newdiv;
		console.log(Object.keys(dico).length);
              compteur+=1;
		id++;
         }
}

function buttonClick(s) {
	var is=parseInt(s);
	document.getElementById('dynamicInput').removeChild(dico[is]);
	delete dico[is];

	compteur=Object.keys(dico).length;
	console.log(compteur);
}
