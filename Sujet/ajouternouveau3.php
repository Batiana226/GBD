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
<h1>Page permettant d'ajouter un nouveau type de materiel dans la base 3/4</h1>

<?php
        // Cette fonction, fondamentale, prend en entrée la requête et renvoie
        // un array resultat composé de 2 éléments, le nombre d'enregistrements trouvé resultat[0]
        // et la liste des enregistrements resultat[1]
        // resultat[1][x] permet d'accéder au x ème enregistrement
        // resultat{1][x][y] permet d'accéder à la valeur de la colonne y pour l'enregistrement x
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

                return array($rows, $table_1);
        }

	$nomMateriel=$_SESSION['nomMateriel'];
	echo $nomMateriel."<br>";
	$tmMateriel="tm_".$nomMateriel;

	$rows=0;
	if($_SERVER["REQUEST_METHOD"] == "POST")
 	{
    		$myColumns = $_POST["myColumns"];
    		$myFields = $_POST["myFields"];

		$i=0;
		while ($i<sizeof($myColumns))
		{
			echo $i." ".$myColumns[$i]." ".$myFields[$i]."<br>";
			$i++;
		}
 	}  

	$query="";

	??

	$_SESSION['query']=$query;
?>

<p> La requête SQL de création de la table a été construite. </p>

<form method="post" action="ajouternouveau4.php">
        <input type="submit" name="submit" value="Créer la table">
</form>

</body>
</html>
