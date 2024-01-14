<?php 
session_start();
require("inc/db.php");
include("inc/header.php")

?>
<div class="container">
    <a href="gerer.php" class="btn btn-light mb-3">
        << Retour</a>
            <?php if (isset($_GET['status']) && $_GET['status'] == "created") : ?>
            <div class="alert alert-success" role="alert">
                <strong>Created</strong>
            </div>
            <?php endif ?>
            <?php if (isset($_GET['status']) && $_GET['status'] == "fail_create") : ?>
            <div class="alert alert-danger" role="alert">
                <strong>Fail Create</strong>
            </div>
            <?php endif ?>
            <!-- Create Form -->
            <div class="card border-primary">
                <div class="card-header bg-primary text-white">
                    <strong><i class="fa fa-plus"></i> Ajouter un évènement</strong>
                </div>
                <div class="card-body">
                    <form action="create.php" method="post" enctype="multipart/form-data">
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="nom" class="col-form-label">Titre</label>
                                <input type="text" class="form-control" id="nom" name="nom">
                            </div>
                            <div class="form-group col-md-6">
                                <label for="description" class="col-form-label">Description</label>
                                <input type="textarea" class="form-control" id="description" name="description">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-md-5">
                                <label for="adresse" class="col-form-label">Adresse</label>
                                <input type="text" class="form-control" id="adresse" name="adresse">
                            </div>




                            <div class="form-group col-md-10">

                                <?php 

                        $servername = "localhost";
                        $username = "root";
                        $password = "";
                        $db = "projetweb";

                        // Create connection
                        $con = mysqli_connect($servername, $username, $password,$db);

                        // Check connection
                        if (!$con) {
                            die("Connection failed: " . mysqli_connect_error());
                        }
                        $theme="SELECT * FROM clubs";
                        $listeth=mysqli_query($con,$theme);
                       
                    ?>


                                <label for="theme" class="col-form-label">Thème</label>
                                <!-- <input type="text" class="form-control" name="theme" id="theme" > -->
                                <select name="theme">
                                    <?php while ($row = mysqli_fetch_array($listeth)):?>

                                    <option value="<?php echo $row[0]; ?>">
                                        <?php echo $row[2]; ?>
                                    </option>
                                    <?php endwhile; ?>

                                </select>


                            </div>
                            <div class="form-group col-md-10">
                                <label for="nbPlaces" class="col-form-label">Nombre de places</label>
                                <input type="number" class="form-control" name="nbPlaces" id="nbPlaces">
                            </div>
                            <div class="form-group col-md-5">
                                <label for="image" class="col-form-label">Image</label>
                                <input type="file" class="form-control" name="image" id="image" placeholder="Image URL">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="dateDeb" class="col-form-label">Date de début</label>
                            <input type="text" required pattern="[0-9]{4}-[0-9]{2}-[0-9]{2}" class="form-control"
                                name="dateDeb" id="dateDeb" placeholder="YYYY-MM-DD">
                        </div>
                        <div class="form-group">
                            <label for="dateFin" class="col-form-label">Date de fin</label>
                            <input type="text" required pattern="[0-9]{4}-[0-9]{2}-[0-9]{2}" class="form-control"
                                name="dateFin" id="dateFin" placeholder="YYYY-MM-DD">
                        </div>
                        <div class="form-group">
                            <label for="lat" class="col-form-label">Latitude</label>
                            <input type="text" class="form-control" name="lat" id="lat">
                        </div>
                        <div class="form-group">
                            <label for="long" class="col-form-label">Longitude</label>
                            <input type="text" class="form-control" name="long" id="long">
                        </div>
                        <button type="submit" name="ajouter" class="btn btn-success"><i class="fa fa-check-circle"></i>
                            Enregistrer</button>
                    </form>
                </div>
            </div>
            <!-- End create form -->
            <br>
</div><!-- /.container -->
<?php include("inc/footer.php") ?>


<?php 
include "inc/db.php";

if (isset($_POST['ajouter'])){
    // récupérer les données du formulaire
    $nom = $_POST['nom'];
    $description = $_POST['description'];
    $adresse = $_POST['adresse'];
    $theme = $_POST['theme'];
    $nbPlaces = $_POST['nbPlaces'];
    $dateDeb = $_POST['dateDeb'];
    $dateFin = $_POST['dateFin'];
    $emailcont = $_SESSION['email'];
    $lat = $_POST['lat'];
    $long = $_POST['long'];
    $file_name = $_FILES['image']['name'];
    $file_tmp = $_FILES['image']['tmp_name'];

    // Préparation de la requête SQL avec des paramètres liés
    $sql = "INSERT INTO `evenement` (`idEven`, `nom`, `description`, `adresse`, `latitude`, `longitude`, `nbPlaces`, `dateDeb`, `dateFin`, `theme`, `emailContrib`, `event_img`) 
    VALUES (0, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    // Préparation de la requête avec mysqli
    $stmt = $con->prepare($sql);

    // Liaison des paramètres
    $stmt->bind_param("ssssssissss", $nom, $description, $adresse, $lat, $long, $nbPlaces, $dateDeb, $dateFin, $theme, $emailcont, $file_name);

    // Exécution de la requête
    $stmt->execute();

    // Vérification de l'exécution et gestion des erreurs
    if($stmt->affected_rows > 0){
        echo "<script>alert('Évènement ajouté !')</script>";
    } else {
        echo "<script>alert('Error')</script>";
    }

    // Déplacement du fichier téléchargé
    if (move_uploaded_file($file_tmp, "../images/" . $file_name)) {
        echo "Le fichier a été téléchargé avec succès.";
    } else {
        echo "Une erreur s'est produite lors du téléchargement du fichier.";
    }


}


?>