<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">
<html>
<head>
  <title>Page listant les personnes de la base</title>
  <link rel="stylesheet" href="style3.css">
  <meta charset="UTF-8"> 
</head>

<body>

<!-- Contenu principal -->
<h1>affichage filtré des personnes !</h1>

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

	$rows=0;
	if($_SERVER["REQUEST_METHOD"] == "POST")
 	{
  		$promo = $_POST["promo"];
  		//echo "extraire l index ".$value ; echo " par la requête ";
  		if ($promo!=0)
    		{ 
			$queryPersonne="SELECT * FROM matos2.personne p where p.promo_idpromo = '".$promo."'";
			echo $queryPersonne."<br>";
			$resultPersonne = query_database($queryPersonne);
			$rows=$resultPersonne[0];
		}
 	}  
 ?>
	<table>
	<tr>
		<th>idpersonne</th>
		<th>prénom</th>
		<th>nom</th>
	</tr>
 
<?php
        for ($j = 0 ; $j < $rows ; ++$j)
        {
                echo "<tr>";
                        echo "<td>"; echo $resultPersonne[1][$j][0]; echo "</td>";
                        echo "<td>"; echo utf8_encode($resultPersonne[1][$j][1]); echo "</td>";
                        echo "<td>"; echo utf8_encode($resultPersonne[1][$j][2]); echo "</td>";
                echo "</tr>";
        }
?>

	</table>

</body>
</html>
