<!DOCTYPE html>
<html lang="en">
<link href="https://fonts.googleapis.com/css2?family=Cinzel&display=swap" rel="stylesheet">
<head>
    <meta charset="UTF-8">
    <title>Votre Page</title>
    <!-- Lien vers votre fichier CSS -->
    <link rel="stylesheet" href="style.css">
    <style>
        /* Style pour .jumbotron */
        .jumbotron {
            text-align: center;
            background-image: linear-gradient(to bottom, rgba(0, 0, 0, 0), rgba(240, 240, 240, 1)),
                url('images/DSC_7089-scaled.jpg'); /* Chemin relatif vers votre image */
			margin-top: 30px;
            background-repeat: no-repeat;
            background-size: 100%; /* Ou utilisez 'auto' pour la taille originale */
            background-position: center; /* Optionnel: centre l'image */
            color: black;
            width: 100%;
        }
        #ensak {
            font-family: 'Cinzel', sans-serif;
            font-size: 200px; /* Taille pour "ENSAK" */
        }

        #events {
            font-family: 'Cinzel', sans-serif;
            font-size: 150px; /* Taille pour "Events" */
        }
    </style>
</head>

<body>
    <!-- Contenu de la page -->
        <div class="jumbotron">
            <h1 class="display-4" id="ensak">ENSAK</h1>
            <h1 class="display-4" id="events">Events</h1>
        </div>
    <!-- Autres éléments de votre page -->
</body>

</html>
