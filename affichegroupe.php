<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">
<html>
<head>
  <title>Accueil</title>
  <link rel="stylesheet" href="monstyle.css">
  <meta charset="UTF-8"> 
</head>

<body>

<!-- Menu de navigation du site -->
<ul class="navbar">
      <li><a href="home.html">Accueil</a>
      <li><a href="listerpersonnes.php">lister les personnes</a>
      <li><a href="listerpromos.php">afficher élèves parpromotion.</a>
      <li><a href="listerpromos_genre.php">afficher les élèves par promo et par sexe
         <li><a href="listergroupe.php">lister les groupes</a>
     <!-- <li><a href="listerpersonnes_groupes.php">lister groupes</a>  version 2--> 
      <li><a href="listerpersonnes_par_groupe.php">lister personnes par groupe</a>
      <li><a href="choixDUgroupe.php">lister les personnes par groupe et par promo</a>


</ul>



<!-- Contenu principal -->
<h1>affichage filtré des groupes !</h1>

<?php


  // Cette fonction, fondamentale, prend en entree la requete et renvoie
   // un array resultat compose de 2 elements, le nombre d'enregistrements trouve resultat[0]
  // et la liste des enregistrements resultat[1]
  // resultat[1][x] permet d'acceder au x eme enregistrement
   // resultat{1][x][y] permet d'acceder a la valeur de la colonne y pour l'enregistrement x
   function query_database($q)
   {
      $conn = new mysqli("localhost", "matos2", "matos2", "matos2");

      if ($conn->connect_error) die($conn->connect_error);

      $query  = $q;
      $result = $conn->query($query);
      if (!$result) die ("Database access failed: " . $conn->error);

      $rows = $result->num_rows;

      $table_1 = array();

      for ($j = 0 ; $j < $rows ; ++$j)
        {
           $result->data_seek($j);
           $row = $result->fetch_row();

           array_push($table_1,$row);
        }

        $result->close();
        $conn->close();

        return array($rows, $table_1);
   }



  $rows=0;

  if($_SERVER["REQUEST_METHOD"] == "POST")
  {
        $groupe = $_POST["groupe"];

        if (!empty($_POST["ajoutEleve"]))
        {

          $ajoutEleve = $_POST["ajoutEleve"];

            if ($ajoutEleve != -1)
             {
                $query  = "INSERT INTO personne_has_groupe (personne_idpersonne,groupe_idgroupe) VALUES (".$ajoutEleve.",".$groupe.")";
                $conn = new mysqli("localhost","matos2", "matos2", "matos2");
                $result = $conn->query($query);   
            } 

        }

        if (!empty($_POST['supprimeEleve']))
        {
  
    
            $supprimeEleve = $_POST["supprimeEleve"];

            if ($supprimeEleve != -1) 
            {
                $query  = "DELETE personne_has_groupe.* FROM personne_has_groupe WHERE personne_has_groupe.personne_idpersonne = ".$supprimeEleve." AND personne_has_groupe.groupe_idgroupe = ".$groupe;
                $conn = new mysqli("localhost","matos2", "matos2", "matos2");
                $result = $conn->query($query);   
            }   
        }

        $query = "SELECT prenom,nom FROM personne,personne_has_groupe WHERE personne.idpersonne = personne_has_groupe.personne_idpersonne AND personne_has_groupe.groupe_idgroupe = ".$groupe;
        $result1 = query_database($query);

         
        echo "<table>";
        echo "<tr>";
            echo "<th>Prenom</th>";
            echo "<th>Nom</th>";
        echo "</tr>";
            
          
        for ($j = 0 ; $j < $result1[0] ; ++$j)
        {
          echo "<tr>"; 
          echo "<td>"; echo $result1[1][$j][0]; echo "</td>"; 
          echo "<td>"; echo utf8_encode($result1[1][$j][1]); echo "</td>"; 
          echo "</tr>";
        }
          
        echo "</table>";
        echo "<br>";
      
           

        if ($groupe == '1' || $groupe == '2')
        { 
            $query = "SELECT * FROM personne,personne_has_groupe WHERE personne.idpersonne=personne_has_groupe.personne_idpersonne AND personne_has_groupe.groupe_idgroupe != ".$groupe." AND (personne_has_groupe.groupe_idgroupe =1 OR personne_has_groupe.groupe_idgroupe=2)"; 

            $result1 = query_database($query);
        }
         
        else
         { 
            $query = "SELECT * FROM personne,personne_has_groupe WHERE personne.idpersonne=personne_has_groupe.personne_idpersonne AND personne_has_groupe.groupe_idgroupe != ".$groupe." AND (personne_has_groupe.groupe_idgroupe !=1 AND personne_has_groupe.groupe_idgroupe!=2)"; 

            // echo $query ;
            $result1 = query_database($query); 
          }
        
          $query  = "SELECT * FROM personne,personne_has_groupe WHERE personne.idpersonne=personne_has_groupe.personne_idpersonne AND personne_has_groupe.groupe_idgroupe = ".$groupe;
          $result2 = query_database($query);
            
  }  


 ?> 

  <form method=post action="affichegroupe.php">

    <label> Ajouter: </label>
    <select id="AjoutEleve" name="ajoutEleve">

    <option value="-1">Choissisez un eleve</option>

    <?php 
      
      for ($j=0; $j<$result1[0]; $j++)
        echo "<option value=\"".$result1[1][$j][0]."\">".$result1[1][$j][2]." ".$result1[1][$j][1]."</option>";
    
    ?>

    </select>
    <input type="submit" name="submit" value="Ajouter">
    
    <br>

    <label> Supprimer: </label>

    <select id="supprimeEleve" name="supprimeEleve">

    <option value="-1">Choissisez un eleve</option>

    <?php

      for ($j=0; $j<$result2[0]; $j++)
        echo "<option value=\"".$result2[1][$j][0]."\">".$result2[1][$j][2]." ".$result2[1][$j][1]."</option>";
    
    ?>
    </select>

    <input type="hidden" name = "groupe" id="groupe" value="<?php echo $groupe; ?>" />
    <input type="submit" name="submit1" value="Supprimer">
  </form>


</body>
</html>
