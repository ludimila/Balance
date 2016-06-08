App.onLaunh = function(){

    var loadResource = new LoadResourceJS(NativeReourceLoader.create());
    var doc = loadResource.getDocument("view.tvml");
    navigationDocument.pushDocument(doc)
    doc.addEventListener("select", handleEvent);
}

class LoadResourceJS{

    constructor(nativeResourceLoader){
    
        this.nativeResourceLoader = nativeResourceLoader;
        this.domParser = new DOMParser();
    }

    getDocument(name){
    
        var docString = this.nativeReourceLoader.loadBundleResource(name);
        return this.domParser.parseFromString(docString, "application/xml");
    }
    
    function playVideo(title, url){
        
        var player = new Player();
        
        var video = new MediaItem('video',url);
        vide.title = title
        
        player.playlist = new Playlist();
        player.playlist.push(video);
        
        player.play();
        
    }
    
    function handleEvent(event){
        
        var buttonId = event.target.getAttribute("id");
        
        if (buttonId === "play"){
            playVideo("Executar meu video", "https://wolverine.raywenderlich.com/books/tvos-apprentice/helloTVML/hls_playlist.m3u8");
        }
    }
    
    
    
}