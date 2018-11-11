# Sample output responses

# r = RestClient.get "http://192.168.2.10:32400/library", :accept => :json
# GET Library 
{
  "MediaContainer" => {
    "size"=>3,
    "allowSync"=>false,
    "art"=>"/:/resources/library-art.png",
    "content"=>"",
    "identifier"=>"com.plexapp.plugins.library",
    "mediaTagPrefix"=>"/system/bundle/media/flags/",
    "mediaTagVersion"=>1537529855,
    "title1"=>"Plex Library",
    "title2"=>"",
    "Directory"=> [
      {"key"=>"sections", "title"=>"Library Sections" },
      {"key"=>"recentlyAdded", "title"=>"Recently Added Content"},
      {"key"=>"onDeck", "title"=>"On Deck Content"}
    ]
  }
}

# GET ALL Sections
# r = RestClient.get "http://192.168.2.10:32400/library/sections"
{"MediaContainer"=>
  {"size"=>6,
   "allowSync"=>false,
   "identifier"=>"com.plexapp.plugins.library",
   "mediaTagPrefix"=>"/system/bundle/media/flags/",
   "mediaTagVersion"=>1537529855,
   "title1"=>"Plex Library",
   "Directory"=>
    [{"allowSync"=>true,
      "art"=>"/:/resources/movie-fanart.jpg",
      "composite"=>"/library/sections/8/composite/1542179087",
      "filters"=>true,
      "refreshing"=>false,
      "thumb"=>"/:/resources/movie.png",
      "key"=>"8",
      "type"=>"movie",
      "title"=>"4K Movies",
      "agent"=>"com.plexapp.agents.imdb",
      "scanner"=>"Plex Movie Scanner",
      "language"=>"en",
      "uuid"=>"36b7bf82-784e-4c0c-a219-e51549ebc255",
      "updatedAt"=>1536625963,
      "createdAt"=>1512309737,
      "scannedAt"=>1542179087,
      "Location"=>
       [{"id"=>17, "path"=>"/volume4/Media2/Movies_HQ"},
        {"id"=>22, "path"=>"/volume4/Media2/hq_downloads"}]},
     {"allowSync"=>true,
      "art"=>"/:/resources/movie-fanart.jpg",
      "composite"=>"/library/sections/3/composite/1542179093",
      "filters"=>true,
      "refreshing"=>false,
      "thumb"=>"/:/resources/movie.png",
      "key"=>"3",
      "type"=>"movie",
      "title"=>"HEVC_Movies",
      "agent"=>"com.plexapp.agents.imdb",
      "scanner"=>"Plex Movie Scanner",
      "language"=>"en",
      "uuid"=>"aee398a0-2fcf-4d51-aaeb-52645d413676",
      "updatedAt"=>1523567026,
      "createdAt"=>1506717395,
      "scannedAt"=>1542179093,
      "Location"=>[{"id"=>4, "path"=>"/volume2/Media/Movies_HEVC"}]},
     {"allowSync"=>true,
      "art"=>"/:/resources/movie-fanart.jpg",
      "composite"=>"/library/sections/1/composite/1542179221",
      "filters"=>true,
      "refreshing"=>false,
      "thumb"=>"/:/resources/movie.png",
      "key"=>"1",
      "type"=>"movie",
      "title"=>"Movies",
      "agent"=>"com.plexapp.agents.imdb",
      "scanner"=>"Plex Movie Scanner",
      "language"=>"en",
      "uuid"=>"8fe38be2-a339-4e42-9dd4-480fbfa1fc5e",
      "updatedAt"=>1523566987,
      "createdAt"=>1506717364,
      "scannedAt"=>1542179221,
      "Location"=>
       [{"id"=>14, "path"=>"/volume2/Media/downloads"},
        {"id"=>15, "path"=>"/volume2/Media/Movies"}]},
     {"allowSync"=>true,
      "art"=>"/:/resources/photo-fanart.jpg",
      "composite"=>"/library/sections/4/composite/1542179223",
      "filters"=>true,
      "refreshing"=>false,
      "thumb"=>"/:/resources/photo.png",
      "key"=>"4",
      "type"=>"photo",
      "title"=>"Photos",
      "agent"=>"com.plexapp.agents.none",
      "scanner"=>"Plex Photo Scanner",
      "language"=>"en",
      "uuid"=>"e69d91d7-766e-4ff0-879f-ad08f9137a86",
      "updatedAt"=>1510068258,
      "createdAt"=>1510067847,
      "scannedAt"=>1542179223,
      "enableAutoPhotoTags"=>false,
      "Location"=>[{"id"=>7, "path"=>"/volume5/Photos/Albums"}]},
     {"allowSync"=>true,
      "art"=>"/:/resources/movie-fanart.jpg",
      "composite"=>"/library/sections/9/composite/1542179226",
      "filters"=>true,
      "refreshing"=>false,
      "thumb"=>"/:/resources/movie.png",
      "key"=>"9",
      "type"=>"movie",
      "title"=>"Raluca",
      "agent"=>"com.plexapp.agents.imdb",
      "scanner"=>"Plex Movie Scanner",
      "language"=>"en",
      "uuid"=>"f44b53f5-c29b-4f27-902c-766d2dde1072",
      "updatedAt"=>1536621714,
      "createdAt"=>1528591696,
      "scannedAt"=>1542179226,
      "Location"=>[{"id"=>19, "path"=>"/volume4/Media2/_raluca"}]},
     {"allowSync"=>true,
      "art"=>"/:/resources/show-fanart.jpg",
      "composite"=>"/library/sections/2/composite/1542179237",
      "filters"=>true,
      "refreshing"=>false,
      "thumb"=>"/:/resources/show.png",
      "key"=>"2",
      "type"=>"show",
      "title"=>"TV Shows",
      "agent"=>"com.plexapp.agents.thetvdb",
      "scanner"=>"Plex Series Scanner",
      "language"=>"en",
      "uuid"=>"8c4d0168-6ea2-45e4-a4b1-6a9a8280f218",
      "updatedAt"=>1536626006,
      "createdAt"=>1506717377,
      "scannedAt"=>1542179237,
      "Location"=>
       [{"id"=>18, "path"=>"/volume4/Media2/TV"},
        {"id"=>23, "path"=>"/volume4/Media2/tv_downloads"}]}]}}

# RestClient.get "http://192.168.2.10:32400/library/sections/1", :accept => :json

{"MediaContainer"=>
  {"size"=>19,
   "allowSync"=>false,
   "art"=>"/:/resources/movie-fanart.jpg",
   "content"=>"secondary",
   "identifier"=>"com.plexapp.plugins.library",
   "librarySectionID"=>1,
   "mediaTagPrefix"=>"/system/bundle/media/flags/",
   "mediaTagVersion"=>1537529855,
   "thumb"=>"/:/resources/movie.png",
   "title1"=>"Movies",
   "viewGroup"=>"secondary",
   "viewMode"=>65592,
   "Directory"=>
    [{"key"=>"all", "title"=>"All Movies"},
     {"key"=>"unwatched", "title"=>"Unplayed"},
     {"key"=>"newest", "title"=>"Recently Released"},
     {"key"=>"recentlyAdded", "title"=>"Recently Added"},
     {"key"=>"recentlyViewed", "title"=>"Recently Viewed"},
     {"key"=>"onDeck", "title"=>"On Deck"},
     {"secondary"=>true, "key"=>"collection", "title"=>"By Collection"},
     {"secondary"=>true, "key"=>"genre", "title"=>"By Genre"},
     {"secondary"=>true, "key"=>"year", "title"=>"By Year"},
     {"secondary"=>true, "key"=>"decade", "title"=>"By Decade"},
     {"secondary"=>true, "key"=>"director", "title"=>"By Director"},
     {"secondary"=>true, "key"=>"actor", "title"=>"By Starring Actor"},
     {"secondary"=>true, "key"=>"country", "title"=>"By Country"},
     {"secondary"=>true, "key"=>"contentRating", "title"=>"By Content Rating"},
     {"secondary"=>true, "key"=>"rating", "title"=>"By Rating"},
     {"secondary"=>true, "key"=>"resolution", "title"=>"By Resolution"},
     {"secondary"=>true, "key"=>"firstCharacter", "title"=>"By First Letter"},
     {"key"=>"folder", "title"=>"By Folder"},
     {"prompt"=>"Search Movies",
      "search"=>true,
      "key"=>"search?type=1",
      "title"=>"Search..."}]}}

# GET ALL movies in sections
# r = RestClient.get "http://192.168.2.10:32400/library/sections/1/all", :accept => :json

{"MediaContainer"=>
  {"size"=>2,
   "totalSize"=>1868,
   "allowSync"=>true,
   "art"=>"/:/resources/movie-fanart.jpg",
   "identifier"=>"com.plexapp.plugins.library",
   "librarySectionID"=>1,
   "librarySectionTitle"=>"Movies",
   "librarySectionUUID"=>"8fe38be2-a339-4e42-9dd4-480fbfa1fc5e",
   "mediaTagPrefix"=>"/system/bundle/media/flags/",
   "mediaTagVersion"=>1537529855,
   "offset"=>1,
   "sortAsc"=>true,
   "thumb"=>"/:/resources/movie.png",
   "title1"=>"Movies",
   "title2"=>"All Movies",
   "viewGroup"=>"movie",
   "viewMode"=>458810,
   "Metadata"=>
    [{"ratingKey"=>"31448",
      "key"=>"/library/metadata/31448",
      "studio"=>"Universal Pictures",
      "type"=>"movie",
      "title"=>"2 Guns",
      "contentRating"=>"R",
      "summary"=>
       "Two hardened criminals get into trouble with the US border patrol after meeting with a Mexican drug lord, and then revelations start to unfold.",
      "rating"=>6.4,
      "audienceRating"=>6.6,
      "year"=>2013,
      "tagline"=>"2 Guns, 1 Bank.",
      "thumb"=>"/library/metadata/31448/thumb/1532271399",
      "art"=>"/library/metadata/31448/art/1532271399",
      "duration"=>6555370,
      "originallyAvailableAt"=>"2013-08-02",
      "addedAt"=>1523489564,
      "updatedAt"=>1532271399,
      "audienceRatingImage"=>"rottentomatoes://image.rating.spilled",
      "chapterSource"=>"agent",
      "primaryExtraKey"=>"/library/metadata/32224",
      "ratingImage"=>"rottentomatoes://image.rating.ripe",
      "Media"=>
       [{"videoResolution"=>"1080",
         "id"=>67507,
         "duration"=>6555370,
         "bitrate"=>2148,
         "width"=>1920,
         "height"=>800,
         "aspectRatio"=>2.35,
         "audioChannels"=>2,
         "audioCodec"=>"aac",
         "videoCodec"=>"h264",
         "container"=>"mp4",
         "videoFrameRate"=>"24p",
         "optimizedForStreaming"=>1,
         "audioProfile"=>"lc",
         "has64bitOffsets"=>false,
         "videoProfile"=>"high",
         "Part"=>
          [{"id"=>67782,
            "key"=>"/library/parts/67782/1383905481/file.mp4",
            "duration"=>6555370,
            "file"=>
             "/volume2/Media/Movies/2 Guns (2013) [1080p]/2 Guns (2013) [1080p] [AAC 2ch].mp4",
            "size"=>1760468767,
            "audioProfile"=>"lc",
            "container"=>"mp4",
            "has64bitOffsets"=>false,
            "optimizedForStreaming"=>true,
            "videoProfile"=>"high"}]}],
      "Genre"=>[{"tag"=>"Action"}, {"tag"=>"Comedy"}],
      "Director"=>[{"tag"=>"Baltasar Kormákur"}],
      "Writer"=>[{"tag"=>"Blake Masters"}],
      "Country"=>[{"tag"=>"USA"}],
      "Role"=>
       [{"tag"=>"Denzel Washington"},
        {"tag"=>"Mark Wahlberg"},
        {"tag"=>"Paula Patton"}]},
     {"ratingKey"=>"30065",
      "key"=>"/library/metadata/30065",
      "studio"=>"Wonderland Sound and Vision",
      "type"=>"movie",
      "title"=>"3 Days to Kill",
      "contentRating"=>"PG-13",
      "summary"=>
       "A dying CIA agent trying to reconnect with his estranged daughter is offered an experimental drug that could save his life in exchange for one last assignment.",
      "rating"=>2.8,
      "audienceRating"=>4.3,
      "year"=>2014,
      "thumb"=>"/library/metadata/30065/thumb/1532271486",
      "art"=>"/library/metadata/30065/art/1532271486",
      "duration"=>7338858,
      "originallyAvailableAt"=>"2014-02-14",
      "addedAt"=>1523489314,
      "updatedAt"=>1532271486,
      "audienceRatingImage"=>"rottentomatoes://image.rating.spilled",
      "chapterSource"=>"agent",
      "primaryExtraKey"=>"/library/metadata/32323",
      "ratingImage"=>"rottentomatoes://image.rating.rotten",
      "Media"=>
       [{"videoResolution"=>"1080",
         "id"=>66124,
         "duration"=>7338858,
         "bitrate"=>2161,
         "width"=>1920,
         "height"=>808,
         "aspectRatio"=>2.35,
         "audioChannels"=>2,
         "audioCodec"=>"aac",
         "videoCodec"=>"h264",
         "container"=>"mp4",
         "videoFrameRate"=>"24p",
         "optimizedForStreaming"=>1,
         "audioProfile"=>"lc",
         "has64bitOffsets"=>false,
         "videoProfile"=>"high",
         "Part"=>
          [{"id"=>66399,
            "key"=>"/library/parts/66399/1405933914/file.mp4",
            "duration"=>7338858,
            "file"=>
             "/volume2/Media/Movies/3 Days to Kill (2014) [1080p]/3 Days to Kill (2014) [1080p] [AAC 2ch].mp4",
            "size"=>1981957797,
            "audioProfile"=>"lc",
            "container"=>"mp4",
            "has64bitOffsets"=>false,
            "optimizedForStreaming"=>true,
            "videoProfile"=>"high"}]}],
      "Genre"=>[{"tag"=>"Action"}, {"tag"=>"Drama"}],
      "Director"=>[{"tag"=>"McG"}],
      "Writer"=>[{"tag"=>"Adi Hasak"}, {"tag"=>"Luc Besson"}],
      "Country"=>[{"tag"=>"USA"}],
      "Role"=>
       [{"tag"=>"Kevin Costner"},
        {"tag"=>"Hailee Steinfeld"},
        {"tag"=>"Connie Nielsen"}]}]}}



# GET Movie details
# r = RestClient.get "http://192.168.2.10:32400/library/metadata/31448", :accept => :json

{"MediaContainer"=>
  {"size"=>1,
   "allowSync"=>true,
   "identifier"=>"com.plexapp.plugins.library",
   "librarySectionID"=>1,
   "librarySectionTitle"=>"Movies",
   "librarySectionUUID"=>"8fe38be2-a339-4e42-9dd4-480fbfa1fc5e",
   "mediaTagPrefix"=>"/system/bundle/media/flags/",
   "mediaTagVersion"=>1537529855,
   "Metadata"=>
    [{"ratingKey"=>"31448",
      "key"=>"/library/metadata/31448",
      "guid"=>"com.plexapp.agents.imdb://tt1272878?lang=en",
      "librarySectionTitle"=>"Movies",
      "librarySectionID"=>1,
      "librarySectionKey"=>"/library/sections/1",
      "studio"=>"Universal Pictures",
      "type"=>"movie",
      "title"=>"2 Guns",
      "contentRating"=>"R",
      "summary"=>
       "Two hardened criminals get into trouble with the US border patrol after meeting with a Mexican drug lord, and then revelations start to unfold.",
      "rating"=>6.4,
      "audienceRating"=>6.6,
      "year"=>2013,
      "tagline"=>"2 Guns, 1 Bank.",
      "thumb"=>"/library/metadata/31448/thumb/1532271399",
      "art"=>"/library/metadata/31448/art/1532271399",
      "duration"=>6555370,
      "originallyAvailableAt"=>"2013-08-02",
      "addedAt"=>1523489564,
      "updatedAt"=>1532271399,
      "audienceRatingImage"=>"rottentomatoes://image.rating.spilled",
      "chapterSource"=>"agent",
      "primaryExtraKey"=>"/library/metadata/32224",
      "ratingImage"=>"rottentomatoes://image.rating.ripe",
      "Media"=>
       [{"videoResolution"=>"1080",
         "id"=>67507,
         "duration"=>6555370,
         "bitrate"=>2148,
         "width"=>1920,
         "height"=>800,
         "aspectRatio"=>2.35,
         "audioChannels"=>2,
         "audioCodec"=>"aac",
         "videoCodec"=>"h264",
         "container"=>"mp4",
         "videoFrameRate"=>"24p",
         "optimizedForStreaming"=>1,
         "audioProfile"=>"lc",
         "has64bitOffsets"=>false,
         "videoProfile"=>"high",
         "Part"=>
          [{"id"=>67782,
            "key"=>"/library/parts/67782/1383905481/file.mp4",
            "duration"=>6555370,
            "file"=>
             "/volume2/Media/Movies/2 Guns (2013) [1080p]/2 Guns (2013) [1080p] [AAC 2ch].mp4",
            "size"=>1760468767,
            "audioProfile"=>"lc",
            "container"=>"mp4",
            "has64bitOffsets"=>false,
            "optimizedForStreaming"=>true,
            "videoProfile"=>"high",
            "Stream"=>
             [{"id"=>152424,
               "streamType"=>1,
               "default"=>true,
               "codec"=>"h264",
               "index"=>0,
               "bitrate"=>2051,
               "bitDepth"=>8,
               "chromaLocation"=>"left",
               "chromaSubsampling"=>"4:2:0",
               "colorPrimaries"=>"bt709",
               "colorRange"=>"tv",
               "colorSpace"=>"bt709",
               "frameRate"=>23.976,
               "hasScalingMatrix"=>false,
               "height"=>800,
               "level"=>41,
               "profile"=>"high",
               "refFrames"=>4,
               "streamIdentifier"=>"1",
               "width"=>1920,
               "displayTitle"=>"1080p (H.264)"},
              {"id"=>152425,
               "streamType"=>2,
               "selected"=>true,
               "default"=>true,
               "codec"=>"aac",
               "index"=>1,
               "channels"=>2,
               "bitrate"=>98,
               "language"=>"English",
               "languageCode"=>"eng",
               "audioChannelLayout"=>"stereo",
               "profile"=>"lc",
               "samplingRate"=>48000,
               "streamIdentifier"=>"2",
               "displayTitle"=>"English (AAC Stereo)"}]}]}],
      "Genre"=>
       [{"id"=>27, "filter"=>"genre=27", "tag"=>"Action"},
        {"id"=>26, "filter"=>"genre=26", "tag"=>"Comedy"},
        {"id"=>40607, "filter"=>"genre=40607", "tag"=>"Crime"},
        {"id"=>41187, "filter"=>"genre=41187", "tag"=>"Thriller"}],
      "Director"=>
       [{"id"=>73981, "filter"=>"director=73981", "tag"=>"Baltasar Kormákur"}],
      "Writer"=>
       [{"id"=>80322, "filter"=>"writer=80322", "tag"=>"Blake Masters"}],
      "Producer"=>
       [{"id"=>42225, "filter"=>"producer=42225", "tag"=>"Randall Emmett"},
        {"id"=>45225, "filter"=>"producer=45225", "tag"=>"George Furla"},
        {"id"=>42227, "filter"=>"producer=42227", "tag"=>"Norton Herrick"},
        {"id"=>80339, "filter"=>"producer=80339", "tag"=>"Ross Richie"},
        {"id"=>80338, "filter"=>"producer=80338", "tag"=>"Adam Siegel"},
        {"id"=>52803, "filter"=>"producer=52803", "tag"=>"Marc Platt"},
        {"id"=>80340, "filter"=>"producer=80340", "tag"=>"Andrew Cosby"}],
      "Country"=>[{"id"=>42319, "filter"=>"country=42319", "tag"=>"USA"}],
      "Role"=>
       [{"id"=>43723,
         "filter"=>"actor=43723",
         "tag"=>"Denzel Washington",
         "role"=>"Bobby"},
        {"id"=>42177,
         "filter"=>"actor=42177",
         "tag"=>"Mark Wahlberg",
         "role"=>"Stig"},
        {"id"=>46701,
         "filter"=>"actor=46701",
         "tag"=>"Paula Patton",
         "role"=>"Deb"},
        {"id"=>46289,
         "filter"=>"actor=46289",
         "tag"=>"Bill Paxton",
         "role"=>"Earl"},
        {"id"=>46835,
         "filter"=>"actor=46835",
         "tag"=>"Edward James Olmos",
         "role"=>"Papi Greco",
         "thumb"=>"https://thetvdb.com/banners/actors/408079.jpg"},
        {"id"=>49755,
         "filter"=>"actor=49755",
         "tag"=>"Robert John Burke",
         "role"=>"Jessup"},
        {"id"=>41972,
         "filter"=>"actor=41972",
         "tag"=>"James Marsden",
         "role"=>"Quince",
         "thumb"=>"https://thetvdb.com/banners/actors/351974.jpg"},
        {"id"=>80326,
         "filter"=>"actor=80326",
         "tag"=>"Greg Sproles",
         "role"=>"Chief Lucas"},
        {"id"=>50135,
         "filter"=>"actor=50135",
         "tag"=>"Fred Ward",
         "role"=>"Admiral Tuwey"},
        {"id"=>53205,
         "filter"=>"actor=53205",
         "tag"=>"Patrick Fischler",
         "role"=>"Dr. Ken"}],
      "Similar"=>
       [{"id"=>111456, "filter"=>"similar=111456", "tag"=>"Pain & Gain"},
        {"id"=>94895, "filter"=>"similar=94895", "tag"=>"R.I.P.D."},
        {"id"=>94897, "filter"=>"similar=94897", "tag"=>"White House Down"},
        {"id"=>94903, "filter"=>"similar=94903", "tag"=>"Escape Plan"},
        {"id"=>94981, "filter"=>"similar=94981", "tag"=>"RED 2"},
        {"id"=>94944,
         "filter"=>"similar=94944",
         "tag"=>"Jack Ryan: Shadow Recruit"},
        {"id"=>94910, "filter"=>"similar=94910", "tag"=>"Safe House"},
        {"id"=>94942, "filter"=>"similar=94942", "tag"=>"Homefront"},
        {"id"=>94947, "filter"=>"similar=94947", "tag"=>"Shooter"},
        {"id"=>94908, "filter"=>"similar=94908", "tag"=>"Contraband"},
        {"id"=>94943, "filter"=>"similar=94943", "tag"=>"Lone Survivor"},
        {"id"=>111458, "filter"=>"similar=111458", "tag"=>"3 Days to Kill"},
        {"id"=>111459, "filter"=>"similar=111459", "tag"=>"Killer Elite"},
        {"id"=>94795,
         "filter"=>"similar=94795",
         "tag"=>"The Taking of Pelham 1 2 3"},
        {"id"=>94937, "filter"=>"similar=94937", "tag"=>"Non-Stop"},
        {"id"=>94810, "filter"=>"similar=94810", "tag"=>"Unstoppable"},
        {"id"=>113403, "filter"=>"similar=113403", "tag"=>"Safe"},
        {"id"=>94980, "filter"=>"similar=94980", "tag"=>"Need for Speed"},
        {"id"=>94959, "filter"=>"similar=94959", "tag"=>"The Equalizer"},
        {"id"=>113404, "filter"=>"similar=113404", "tag"=>"Ride Along"}]}]}}