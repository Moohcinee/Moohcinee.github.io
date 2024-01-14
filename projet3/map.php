<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    body, html {
      margin: 0;
      padding: 0;
      height: 100%;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
    }

    iframe {
      width: 200%; /* Augmentez davantage la largeur comme vous le souhaitez */
      height: 1200px; /* Gardez ou ajustez la hauteur selon vos besoins */
      border: 0;
    }

    #map-info {
      text-align: center;
      margin-top: 20px;
    }

    #index-link {
      margin-top: 20px;
    }

    #index-link button {
      background-color: blue; /* Changez la couleur du bouton en bleu */
      color: white; /* Changez la couleur du texte en blanc */
      padding: 10px 20px; /* Ajoutez du rembourrage pour un meilleur aspect */
      border: none;
      border-radius: 5px; /* Ajoutez des coins arrondis au bouton */
      text-decoration: none;
      cursor: pointer;
    }
  </style>
</head>
<body>
  <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d4692.556599504047!2d-6.584898949772729!3d34.24863037597122!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0xda759f9847310ff%3A0xfcdd86f18958657d!2sENSA%20%3A%20%C3%89cole%20Nationale%20des%20Sciences%20Appliqu%C3%A9es_K%C3%A9nitra!5e0!3m2!1sfr!2sma!4v1705154807137!5m2!1sfr!2sma" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>

  <div id="map-info">
    <h2>Position sur la carte</h2>
  </div>

  <a href="index.php" id="index-link">
    <button>Retour vers acceuil </button>
  </a>
</body>
</html>
