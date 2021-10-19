<? php
  session_start();
?>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">
<html>
<head>
  <title>Page permettant d'ajouter un nouveau type de materiel dans la base</title>
  <link rel="stylesheet" href="style4.css">
  <meta charset="UTF-8"> 
</head>

<body>

<!-- Contenu principal -->
<h1>Page d'ajout d'un nouveau type de materiel 1/4</h1>

<?php
        // Cette fonction, fondamentale, prend en entrée la requête et renvoie
        // un array resultat composé de 2 éléments, le nombre d'enregistrements trouvé resultat[0]
        // et la liste des enregistrements resultat[1]
        // resultat[1][y] permet d'accéder au y ème enregistrement
        // resultat{1][y][x] permet d'accéder à la valeur de la colonne x pour l'enregistrement y
        function query_database($q)
        {
                // rappel : mysqli("hostname","username","password","database");
                $conn = new mysqli("localhost","matos3", "matos3", "matos3");

                if ($conn->connect_error) die($conn->connect_error);

                $query  = $q;
                $result = $conn->query($query);
                if (!$result)
                        die ("Database access failed: " . $conn->error);

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

		// array(0) contient le nombre d'enregistrements
		// array(1) contient tous les enregistrements
                return array($rows, $table_1);
        }

	// Fonction permettant de nettoyer les données reçues depuis le formulaire.
	// En théorie, il faudrait l'appeler pour chaque champ text du formulaire
	// pour éviter l'injection maligne de commandes php fraduleuses.
 
	function test_input($data)
	{
		$data = trim($data);
		$data = stripslashes($data);
		$data = htmlspecialchars($data);
		return $data;
	}

	// Quand on charge la page, on commence par dire qu'il n'y a pas d'erreurs
	// dedans

	$errors = 0;
    $nomMateriel = "";
    $nomMaterielErr = "";

	// Si le formulaire est bien rempli avec la méthode POST

	if ($_SERVER["REQUEST_METHOD"] == "POST")
	{

		// On commence par regarder si le champ text nomMateriel est vide. Si oui,
		// c'est une erreur

		if (empty($_POST["nomMateriel"]))
         {
             $nomMaterielErr = "Le nom du matériel doit être rempli";
             ++$errors;
         }
		// Sinon, on regarde si le nom nomMateriel est déjà dans la
		// base, dans la table matériel

		else
		{

			$nomMateriel = $_POST['nomMateriel'];
            $query = "SELECT * FROM materiel WHERE nom = '".$nomMateriel."'";
            echo $query; 
            $result = query_database($query);

            if($result[0] > 0)
            {
                $nomMaterielErr = "Le nom exist déja";
                ++$errors;

            }
		}

		// Si on n'a pas eu d'erreur, cela veut dire que le champ nomMateriel est bien rempli
		// et qu'il ne correspond pas à un nom de matériel déjà existant.
		// Tout va donc bien, on va pouvoir maintenant aller à la page suivante, qui permet
		// de choisir le nom et le type des différentes colonnes.
		// On met nomMateriel dans le dico $_SESSION pour pouvoir le passer à la page suivante en paramètre

                if ($errors==0)
                {
			??
                }
	}


?>

<p><span class="error">* champs requis.</span></p>
<form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>">

	??

        <br><br>
        <input type="submit" name="submit" value="Valider">
</form>
  
</body>
</html>
