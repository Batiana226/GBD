<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">
<html>
<head>
  <title>Page listant les personnes de la base</title>
  <link rel="stylesheet" href="style3.css">
  <meta charset="UTF-8"> 
</head>

<body>

<!-- Contenu principal -->
<h1>Lister les personnes !</h1>

<?php
        // Cette fonction, fondamentale, prend en entree la requete et renvoie
        // un array resultat compose de 2 elements, le nombre d'enregistrements trouve resultat[0]
        // et la liste des enregistrements resultat[1]
        // resultat[1][y] permet d'acceder au y eme enregistrement
        // resultat{1][y][x] permet d'acceder a la valeur de la colonne x pour l'enregistrement y
        function query_database($q)
        {     // rappel : mysqli("hostname","username","password","database");
                $conn = new mysqli("localhost","matos2", "matos2", "matos2");
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

  	$query  = "SELECT * FROM personne";
  	$result = query_database($query);
?>
  
	<table>
	<tr>
		<th>idpersonne</th>
		<th>prénom</th>
		<th>nom</th>
	</tr>
  
<?php
  	for ($j = 0 ; $j < $result[0] ; ++$j)
  	{
    		echo "<tr>"; 
			echo "<td>"; echo $result[1][$j][0]; echo "</td>"; 
			echo "<td>"; echo utf8_encode($result[1][$j][1]); echo "</td>"; 
			echo "<td>"; echo utf8_encode($result[1][$j][2]); echo "</td>"; 
    		echo "</tr>";
  	}
?>

	</table>
  
</body>
</html>
