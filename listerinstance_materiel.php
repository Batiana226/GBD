<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">
<html>
<head>
  <title>Page listant les instance_materiel de la base</title>
  <link rel="stylesheet" href="style3.css">
  <meta charset="UTF-8"> 
</head>

<body>

<!-- Contenu principal -->
<h1>Lister les instance_materiel avec les infos specifiques!</h1>

<?php
	// Cette fonction, fondamentale, prend en entree la requete et renvoie
	// un array resultat compose de 2 elements, le nombre d'enregistrements trouve resultat[0]
	// et la liste des enregistrements resultat[1] 
	// resultat[1][x] permet d'accéder au x eme enregistrement
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

	// On commence par rechercher toutes les instance_materiel

  	$query  = "SELECT * FROM instance_materiel";
  	$resInstance_materiel = query_database($query);

	// A la sortie $resInstance_materiel[0] contient le nombre d'enregistrements
	// A la sortie $resInstance_materiel[1][$i] contient tous les enregistrements
	// A la sortie $resInstance_materiel[1][enregistrement][colonne]
	// colonne 0 idinstance_materiel
	// colonne 1 ean13
	// colonne 2 poids 
	// colonne 3 cle etrangere reference dans materiel
	// colonne 4 cle etrangere auto-reference pas utilisee ici 

	$total=array();
	// Pour toutes celles-ci
	for ($i=0;$i<$resInstance_materiel[0];++$i)
	{
		// On recherche le type de materiel associe dans la table materiel et on construit le nom de la
		// table specifique $specTable
		$query="SELECT m.nom FROM materiel m WHERE m.idmateriel='".$resInstance_materiel[1][$i][3]."'";
  		$resMateriel = query_database($query);
		$specTable="tm_".$resMateriel[1][0][0];
		//echo $specTable;

		// On cherche de maniere dynamique les colonnes qui composent la table spécifique
		// et on s'en sert pour construire une liste des colonnes qui nous intéressent
		// liste qui servira pour le select suivant
		$query2="SHOW columns FROM ".$specTable;
  		$resQuery2 = query_database($query2);
		$columns="";

		// L'indice commence a  2 car on sait que la cle primaire et de la cle etrangere vers instance_materiel
		// sont les 2 premieres colonnes de toutes les tables specifiques
		// Ne doit rendre qu'un enregistrement
		for ($j=2;$j<$resQuery2[0];++$j)
		{
			$columns.=$resQuery2[1][$j][0].",";
			//echo $resQuery2[1][$j][0]."<br>";
		}
		$columns=substr($columns,0,-1);
		//echo $columns."<br>";
		
		// On va chercher dans cette table spécifique a l'instance_materiel les infos de colonnes dynamiques demandees
		// Ne doit rendre qu'un enregistrement
		$query3="SELECT ".$columns." FROM ".$specTable." sp WHERE sp.instance_materiel_idinstance_materiel='".$resInstance_materiel[1][$i][0]."'";
		//echo $query3."<br>";
  		$resQuery3 = query_database($query3);
		for ($k=0;$k<$resQuery3[0];++$k)
		{
			//echo count($resQuery3[1][$k])." ".$resQuery3[1][$k][0]."<br>";
		}
		// On ajoute un array de 3 references a l'array $total
		//	array[0] contient la reference vers l'enregistrement instance_materiel
		//	array[1] contient la reference vers la liste des colonnes specifiques 
		//	array[2] contient la reference vers l'enregistrement spécifique a une instance materiel 
		array_push($total,array($resInstance_materiel[1][$i],$resQuery2[1][0],$resQuery3[1][0]));
	}

	$maxColumns=0;
	for ($i=0;$i<count($total);++$i)
	{
		$enregInstance_materiel=$total[$i][0]; // recupere l'enregistrement dans instance_materiel
		$listeColonnes=$total[$i][1];		// recupere le nom des colonnes dans la table specifique
		$valeursColonnes=$total[$i][2];		// recupere l'enregistrement dans la table specifique
		//echo $i." ".$enregInstance_materiel[1]." ".$listeColonnes[1][0]." ".$valeursColonnes[1][0]."<br>";
		//echo $i." ".$enregInstance_materiel[1]." ";
		//echo $enregInstance_materiel[2]." ";
		if (count($valeursColonnes)>$maxColumns)
			$maxColumns=count($valeursColonnes);

		//for ($j=0;$j<count($valeursColonnes);++$j)
		//	echo $valeursColonnes[$j]." ";
		//echo "<br>";
	}
?>
  
	<table>
	<tr>
		<th>idinstance_materiel</th>
		<th>ean13</th>
		<th>poids</th>
<?php
	for ($j=0;$j<$maxColumns;++$j)
		echo "<th>col".$j."</th>";
?>
	</tr>
  
<?php
	for ($i=0;$i<count($total);++$i)
	{
		$enregInstance_materiel=$total[$i][0]; // recupere l'enregistrement dans instance_materiel
		$listeColonnes=$total[$i][1];		// recupere le nom des colonnes dans la table spcifique
		$valeursColonnes=$total[$i][2];		// recupere l'enregistrement dans la table spcifique
		//echo $i." ".$enregInstance_materiel[1]." ".$listeColonnes[1][0]." ".$valeursColonnes[1][0]."<br>";
		//echo $i." ".$enregInstance_materiel[1]." ";
		//echo $enregInstance_materiel[2]." ";

    		echo "<tr>"; 
		echo "<td>"; echo $enregInstance_materiel[0]; echo "</td>"; // L'id
		echo "<td>"; echo $enregInstance_materiel[1]; echo "</td>"; // Le code ean13
		echo "<td>"; echo $enregInstance_materiel[2]; echo "</td>"; // Le poids
		for ($j=0;$j<count($valeursColonnes);++$j)
		{
			echo "<td>";
			echo $valeursColonnes[$j];
			echo "</td>";
		}

		for ($j=count($valeursColonnes);$j<$maxColumns;++$j)
			echo "<td></td>";
    		echo "</tr>";
	}
?>

	</table>
  
</body>
</html>
