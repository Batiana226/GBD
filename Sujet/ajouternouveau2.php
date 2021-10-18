??
??
??

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">
<html>
<head>
  <title>Page permettant d'ajouter un nouveau type de materiel dans la base</title>
  <link rel="stylesheet" href="style4.css">
  <meta charset="UTF-8"> 
</head>

<body>

<!-- Contenu principal -->
<h1>Page d'ajout d'un nouveau type de materiel 2/3</h1>

<?php
        // Cette fonction, fondamentale, prend en entrée la requête et renvoie
        // un array resultat composé de 2 éléments, le nombre d'enregistrements trouvé resultat[0]
        // et la liste des enregistrements resultat[1]
        // resultat[1][y] permet d'accéder au y ème enregistrement
        // resultat{1][y][x] permet d'accéder à la valeur de la colonne x pour l'enregistrement y
        function query_database($q)
        {

		??

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

	$nomMateriel=$_SESSION['nomMateriel'];
	echo "ici<br>";
	echo $nomMateriel;


?>
	<p> La base de données s'apprête à créer une table <?php echo "<b>tm_".$nomMateriel."</b>."; ?> </p>
	<p> Cliquer sur "Ajouter une nouvelle colonne à la table" pour modifier la structure de <?php echo "<b>tm_".$nomMateriel."</b>."; ?> </p>
	<p> Cliquer sur "Valider la structure de la table" pour passer à l'étape suivante. </p>
 
                <form method="POST" action="ajouternouveau3.php">
                        <div id="dynamicInput">
                        </div>

                        <input type="button" value="Ajouter une nouvelle colonne à la table" onClick="addInput('dynamicInput');">

                        <input type="submit" name="submit" value="Valider la structure de la table">

                </form>

                <script src="ajouternouveau.js"></script>
</body>
</html>
