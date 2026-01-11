function movInit()
{
   AlertResponse = "layout";
   CHSStrings = new Object();
   CHSStrings.titles = new Array("保密性","本地存储","麦克风","网络摄像机","启动屏幕共享","安全性","网络摄像机和麦克风的使用","显示","对等协助网络");
   CHSStrings.storageLevels = new Array({label:"从不",value:-1},{label:"无",value:0},{label:"10 KB",value:10},{label:"100 KB",value:100},{label:"1 MB",value:1024},{label:"10 MB",value:10240},{label:"无限制",value:-2});
   CHSStrings.available = new Array(0,10,100,1024,10240,-2);
   CHSStrings.displayAs = new Array("0 KB","10 KB","100 KB","1 MB","10 MB","无限制");
   CHSStrings.windowTitle = "Adobe Flash Player 设置";
   CHSStrings.Close = "关闭";
   CHSStrings.Yes = "是";
   CHSStrings.No = "否";
   CHSStrings.Allow = "允许";
   CHSStrings.OK = "确定";
   CHSStrings.Cancel = "取消";
   CHSStrings.Deny = "拒绝";
   CHSStrings.Retry = "重试";
   CHSStrings.Never = "不再询问";
   CHSStrings.Remember = "记住";
   CHSStrings.Volume = "录音音量:";
   CHSStrings.Echo = "降低回音";
   CHSStrings.PrivacyMsgText = "是否允许 %1 使用您的网络摄像机和麦克风？";
   CHSStrings.PrivacyPopMsgText = "%1 正在请求使用您的摄像头和麦克风。如果您单击“允许”，则可能会录制您的言行。";
   CHSStrings.ScreenPrivacyMsgText = "是否允许 %1 共享您的计算机屏幕？";
   CHSStrings.P2PPrivacyMsgText = "%1 可以使用对等协助网络。是否允许访问您的上载带宽？";
   CHSStrings.StorageMsgText = "%1 可在您的计算机上存储多少信息？";
   CHSStrings.popUp_StorageText = "%1 请求在您的计算机上存储信息。";
   CHSStrings.popUp_StorageData = "请求：最多为 %2<br>当前已使用：%3";
   CHSStrings.storageAlert = "将数量减小到 %2 以下会导致删除 %1 的信息。";
   CHSStrings.securityMsg = "%1 正尝试从 %2 读取。该操作可能不安全。是否允许进行此操作？";
   CHSStrings.securityRemember = "不再询问";
   CHSStrings.Current = "当前已使用:";
   CHSStrings.waitMsg = "正在检测网络摄像机...";
   CHSStrings.noCam = "未找到网络摄像机。";
   CHSStrings.storageError = "并非所有的存储数据都可删除。";
   CHSStrings.Advanced = "高级";
   CHSStrings.local = "本地";
   CHSStrings.videoSafe = "启用硬件加速";
   CHSStrings.installerTitle = "Adobe Flash";
   CHSStrings.installerConnecting = "正在连接...";
   CHSStrings.DP_error_1 = inputState.name;
   CHSStrings.DP_error_2 = "下载出错。是否尝试再次下载？";
   CHSStrings.DP_error_3 = "无法将应用程序写入硬盘，请检查硬盘并再试一次。";
   CHSStrings.kb = "KB";
   CHTStrings = new Object();
   CHTStrings.titles = new Array("私用","本機儲存區","麥克風","網路攝影機","開始螢幕共用","安全性","網路攝影機與麥克風存取權","顯示","對等協助網路");
   CHTStrings.storageLevels = new Array({label:"永不",value:-1},{label:"無",value:0},{label:"10 KB",value:10},{label:"100 KB",value:100},{label:"1 MB",value:1024},{label:"10 MB",value:10240},{label:"無限制",value:-2});
   CHTStrings.available = new Array(0,10,100,1024,10240,-2);
   CHTStrings.displayAs = new Array("0 KB","10 KB","100 KB","1 MB","10 MB","無限制");
   CHTStrings.windowTitle = "Adobe Flash Player 設定";
   CHTStrings.Close = "關閉";
   CHTStrings.Yes = "是";
   CHTStrings.No = "否";
   CHTStrings.Allow = "允許";
   CHTStrings.OK = "確定";
   CHTStrings.Cancel = "取消";
   CHTStrings.Deny = "拒絕";
   CHTStrings.Retry = "重試";
   CHTStrings.Never = "不再詢問";
   CHTStrings.Remember = "記憶";
   CHTStrings.Volume = "錄音音量:";
   CHTStrings.Echo = "降低回音";
   CHTStrings.PrivacyMsgText = "是否允許 %1 存取您的網路攝影機和麥克風？";
   CHTStrings.PrivacyPopMsgText = "%1 要求存取您的網路攝影機及麥克風。如果您按 [允許]，可能會被錄音及錄影。";
   CHTStrings.ScreenPrivacyMsgText = "是否允許 %1 共享您的電腦畫面?";
   CHTStrings.P2PPrivacyMsgText = "%1 可以使用對等協助網路。您是否允許存取您的上傳頻寬?";
   CHTStrings.StorageMsgText = "%1 能在您的電腦上儲存多少資訊？";
   CHTStrings.popUp_StorageText = "%1 要求能在您電腦上儲存資訊的權限。";
   CHTStrings.popUp_StorageData = "要求量:最多 %2<br>目前使用量: %3";
   CHTStrings.storageAlert = "將數量降至 %2 以下，將會移除 %1 所有的資訊。";
   CHTStrings.securityMsg = "%1 試圖讀取 %2。這是一項可能不安全的操作。您是否要允許此項操作？";
   CHTStrings.securityRemember = "不再詢問";
   CHTStrings.Current = "目前使用量:";
   CHTStrings.waitMsg = "正在偵測網路攝影機...";
   CHTStrings.noCam = "找不到網路攝影機。";
   CHTStrings.storageError = "無法移除所有儲存的資料。";
   CHTStrings.Advanced = "進階";
   CHTStrings.local = "本地";
   CHTStrings.videoSafe = "啟動硬體加速";
   CHTStrings.installerTitle = "Adobe Flash";
   CHTStrings.installerConnecting = "連線中...";
   CHTStrings.DP_error_1 = inputState.name;
   CHTStrings.DP_error_2 = "發生下載錯誤。是否嘗試再次下載?";
   CHTStrings.DP_error_3 = "無法將應用程式寫入到硬碟, 請檢查硬碟並再試一次。";
   CHTStrings.kb = "KB";
   english_usStrings = new Object();
   english_usStrings.titles = new Array("Privacy","Local Storage","Microphone","Camera","Start Screen Sharing","Security","Camera and Microphone Access","Display","Peer Assisted Networking");
   english_usStrings.storageLevels = new Array({label:"Never",value:-1},{label:"None",value:0},{label:"10 KB",value:10},{label:"100 KB",value:100},{label:"1 MB",value:1024},{label:"10 MB",value:10240},{label:"Unlimited",value:-2});
   english_usStrings.available = new Array(0,10,100,1024,10240,-2);
   english_usStrings.displayAs = new Array("zero KB","10 KB","100 KB","1 MB","10 MB","unlimited");
   english_usStrings.windowTitle = "Adobe Flash Player Settings";
   english_usStrings.Close = "Close";
   english_usStrings.Yes = "Yes";
   english_usStrings.No = "No";
   english_usStrings.Allow = "Allow";
   english_usStrings.OK = "OK";
   english_usStrings.Cancel = "Cancel";
   english_usStrings.Deny = "Deny";
   english_usStrings.Retry = "Retry";
   english_usStrings.Never = "Never Ask Again";
   english_usStrings.Remember = "Remember";
   english_usStrings.Volume = "Record Volume:";
   english_usStrings.Echo = "Reduce Echo";
   english_usStrings.PrivacyMsgText = "Allow %1 to access your camera and microphone?";
   english_usStrings.PrivacyPopMsgText = "%1 is requesting access to your camera and microphone. If you click Allow, you may be recorded.";
   english_usStrings.ScreenPrivacyMsgText = "Allow %1 to share your computer screen?";
   english_usStrings.P2PPrivacyMsgText = "%1 may use peer assisted networking. Do you want to allow access to your upload bandwidth?";
   english_usStrings.StorageMsgText = "How much information can %1 store on your computer?";
   english_usStrings.popUp_StorageText = "%1 is requesting permission to store information on your computer.";
   english_usStrings.popUp_StorageData = "Requested: up to %2<br>Currently Used: %3";
   english_usStrings.storageAlert = "Decreasing the amount below %2 will cause all information for %1 to be removed.";
   english_usStrings.securityMsg = "%1 is attempting to read from %2. This is a potentially insecure operation. Do you want to allow it?";
   english_usStrings.securityRemember = "Never ask again";
   english_usStrings.Current = "Currently used:";
   english_usStrings.waitMsg = "Detecting cameras...";
   english_usStrings.noCam = "Cannot find camera";
   english_usStrings.storageError = "Not all stored data could be removed.";
   english_usStrings.Advanced = "Advanced";
   english_usStrings.local = "local";
   english_usStrings.videoSafe = "Enable hardware acceleration";
   english_usStrings.installerTitle = "Adobe Flash";
   english_usStrings.installerConnecting = "Connecting...";
   english_usStrings.DP_error_1 = inputState.name;
   english_usStrings.DP_error_2 = "A download error occurred. Try to download again?";
   english_usStrings.DP_error_3 = "Couldn\'t write the application to the hard disk. Please verify the hard disk is available and try again.";
   english_usStrings.kb = "KB";
   frenchStrings = new Object();
   frenchStrings.titles = new Array("Confidentialité","Stockage local","Microphone","Caméra","Démarrer le partage de l\'écran","Sécurité","Accès à la caméra et au microphone","Affichage","Mise en réseau coopérative");
   frenchStrings.storageLevels = new Array({label:"Jamais",value:-1},{label:"Aucun",value:0},{label:"10 Ko",value:10},{label:"100 Ko",value:100},{label:"1 Mo",value:1024},{label:"10 Mo",value:10240},{label:"Illimité",value:-2});
   frenchStrings.available = new Array(0,10,100,1024,10240,-2);
   frenchStrings.displayAs = new Array("0 Ko","10 Ko","100 Ko","1 Mo","10 Mo","illimité");
   frenchStrings.windowTitle = "Paramètres Adobe Flash Player";
   frenchStrings.Close = "Fermer";
   frenchStrings.Yes = "Oui";
   frenchStrings.No = "Non";
   frenchStrings.Allow = "Autoriser";
   frenchStrings.OK = "OK";
   frenchStrings.Cancel = "Annuler";
   frenchStrings.Deny = "Refuser";
   frenchStrings.Retry = "Réessayer";
   frenchStrings.Never = "Jamais";
   frenchStrings.Remember = "Mémoriser";
   frenchStrings.Volume = "Volume d’enregistrement :";
   frenchStrings.Echo = "Réduire l’écho";
   frenchStrings.PrivacyMsgText = "Autoriser %1 à accéder à votre caméra et à votre microphone ?";
   frenchStrings.PrivacyPopMsgText = "%1 demande l\'accès à votre caméra et à votre microphone. Si vous cliquez sur Autoriser, vous risquez d\'être enregistré.";
   frenchStrings.ScreenPrivacyMsgText = "Voulez-vous permettre à %1 de partager l\'écran de votre ordinateur ?";
   frenchStrings.P2PPrivacyMsgText = "%1 peut utiliser la mise en réseau coopérative. \nSouhaitez-vous autoriser l\'accès à votre bande passante de chargement ?";
   frenchStrings.StorageMsgText = "Quelle est la quantité d’informations que %1 peut enregistrer sur votre ordinateur ?";
   frenchStrings.popUp_StorageText = "%1 demande la permission d’enregistrer des informations sur votre ordinateur.";
   frenchStrings.popUp_StorageData = "Demandé : jusqu’à %2<br>Actuellement utilisé : %3";
   frenchStrings.storageAlert = "Un niveau inférieur à %2 entraînera la suppression de toutes les informations pour %1.";
   frenchStrings.securityMsg = "%1 tente de lire à partir de %2. Cette opération peut s\'avérer risquée. Souhaitez-vous l\'autoriser ?";
   frenchStrings.securityRemember = "Ne plus demander";
   frenchStrings.Current = "Actuellement utilisé :";
   frenchStrings.waitMsg = "Détection des caméras...";
   frenchStrings.noCam = "Aucune caméra détectée.";
   frenchStrings.storageError = "Toutes les données enregistrées n’ont pas pu être supprimées.";
   frenchStrings.Advanced = "Avancé";
   frenchStrings.local = "local(e)";
   frenchStrings.videoSafe = "Activer l\'accélération matérielle";
   frenchStrings.installerTitle = "Adobe Flash";
   frenchStrings.installerConnecting = "Connexion en cours...";
   frenchStrings.DP_error_1 = inputState.name;
   frenchStrings.DP_error_2 = "Une erreur de téléchargement s\'est produite. Souhaitez-vous réessayer ?";
   frenchStrings.DP_error_3 = "Impossible d’écrire l’application sur le disque dur. Vérifiez l’espace disque disponible avant de réessayer.";
   frenchStrings.kb = "Ko";
   germanStrings = new Object();
   germanStrings.titles = new Array("Zugriffsschutz","Lokaler Speicher","Mikrofon","Kamera","Gemeinsames Verwenden des Bildschirms beginnen","Sicherheit","Kamera- und Mikrofonzugriff","Anzeige","Peer-Assisted-Networking");
   germanStrings.storageLevels = new Array({label:"Nie",value:-1},{label:"Keine",value:0},{label:"10 KB",value:10},{label:"100 KB",value:100},{label:"1 MB",value:1024},{label:"10 MB",value:10240},{label:"Unbegrenzt",value:-2});
   germanStrings.available = new Array(0,10,100,1024,10240,-2);
   germanStrings.displayAs = new Array("0 KB","10 KB","100 KB","1 MB","10 MB","unbegrenzt");
   germanStrings.windowTitle = "Einstellungen für Adobe Flash Player";
   germanStrings.Close = "Schließen";
   germanStrings.Yes = "Ja";
   germanStrings.No = "Nein";
   germanStrings.Allow = "Zulassen";
   germanStrings.OK = "OK";
   germanStrings.Cancel = "Abbrechen";
   germanStrings.Deny = "Verweigern";
   germanStrings.Retry = "Wiederholen";
   germanStrings.Never = "Nie";
   germanStrings.Remember = "Speichern";
   germanStrings.Volume = "Aufnahmelautstärke:";
   germanStrings.Echo = "Echo reduzieren";
   germanStrings.PrivacyMsgText = "%1 den Zugriff auf Ihre Kamera und Ihr Mikrofon gestatten?";
   germanStrings.PrivacyPopMsgText = "%1 fordert den Zugriff auf Ihre Kamera und Ihr Mikrofon an. Wenn Sie auf \'Zulassen\' klicken, werden Sie evtl. aufgezeichnet.";
   germanStrings.ScreenPrivacyMsgText = "Möchten Sie zulassen, dass %1 den Bildschirm mitverwendet?";
   germanStrings.P2PPrivacyMsgText = "%1 kann Peer-Assisted-Networking verwenden. Möchten Sie den Zugriff auf Ihre Uploadbandbreite zulassen?";
   germanStrings.StorageMsgText = "Wie viele Informationen darf %1 auf Ihrem Computer speichern?";
   germanStrings.popUp_StorageText = "%1 bittet um Genehmigung zur Speicherung von Informationen auf Ihrem Computer.";
   germanStrings.popUp_StorageData = "Angefordert: bis zu %2<br>Gegenwärtig verwendet: %3";
   germanStrings.storageAlert = "Wenn Sie den Wert so weit reduzieren, dass er unter %2 liegt, werden alle Informationen für %1 entfernt.";
   germanStrings.securityMsg = "%1 versucht, von %2 zu lesen. Dieser Vorgang ist unter Umständen nicht sicher. Möchten Sie den Vorgang zulassen?";
   germanStrings.securityRemember = "Nicht mehr fragen";
   germanStrings.Current = "Gegenwärtig verwendet:";
   germanStrings.waitMsg = "Kameras werden erfasst...";
   germanStrings.noCam = "Es wurde keine Kamera gefunden.";
   germanStrings.storageError = "Nicht alle gespeicherten Daten konnten entfernt werden.";
   germanStrings.Advanced = "Erweitert";
   germanStrings.local = "Lokal";
   germanStrings.videoSafe = "Hardwarebeschleunigung aktivieren";
   germanStrings.installerTitle = "Adobe Flash";
   germanStrings.installerConnecting = "Verbindung wird hergestellt...";
   germanStrings.DP_error_1 = inputState.name;
   germanStrings.DP_error_2 = "Downloadfehler aufgetreten. Bitte versuchen Sie es erneut.";
   germanStrings.DP_error_3 = "Die Anwendung konnte nicht auf die Festplatte geschrieben werden. Bitte überprüfen Sie die verfügbare Festplatte und versuchen Sie es noch einmal.";
   germanStrings.kb = "KB";
   italianStrings = new Object();
   italianStrings.titles = new Array("Privacy","Memorizzazione locale","Microfono","Videocamera","Avvia condivisione schermo","Sicurezza","Accesso a videocamera e microfono","Visualizzazione","Connettività peer-to-peer");
   italianStrings.storageLevels = new Array({label:"Mai",value:-1},{label:"Nessuno",value:0},{label:"10 KB",value:10},{label:"100 KB",value:100},{label:"1 MB",value:1024},{label:"10 MB",value:10240},{label:"Illimitati",value:-2});
   italianStrings.available = new Array(0,10,100,1024,10240,-2);
   italianStrings.displayAs = new Array("zero KB","10 KB","100 KB","1 MB","10 MB","illimitata");
   italianStrings.windowTitle = "Impostazioni di Adobe Flash Player";
   italianStrings.Close = "Chiudi";
   italianStrings.Yes = "Sì";
   italianStrings.No = "No";
   italianStrings.Allow = "Consenti";
   italianStrings.OK = "OK";
   italianStrings.Cancel = "Annulla";
   italianStrings.Deny = "Nega";
   italianStrings.Retry = "Riprova";
   italianStrings.Never = "Mai";
   italianStrings.Remember = "Ricorda";
   italianStrings.Volume = "Volume di registrazione";
   italianStrings.Echo = "Riduci eco";
   italianStrings.PrivacyMsgText = "Consentire a %1 di accedere alla videocamera e al microfono in uso?";
   italianStrings.PrivacyPopMsgText = "%1 richiede di accedere alla videocamera e al microfono. Se si fa clic su Consenti, si potrebbe essere oggetto di una registrazione.";
   italianStrings.ScreenPrivacyMsgText = "Consentire a %1 di condividere lo schermo del computer?";
   italianStrings.P2PPrivacyMsgText = "%1 può utilizzare la connettività peer-to-peer. Volete consentire l\'accesso alla vostra ampiezza di banda in upload?";
   italianStrings.StorageMsgText = "Quanti dati può archiviare %1 sul computer in uso?";
   italianStrings.popUp_StorageText = "%1 sta chiedendo il permesso di archiviare informazioni sul computer in uso.";
   italianStrings.popUp_StorageData = "Richiesti: fino a  %2<br>Attualmente in uso: %3";
   italianStrings.storageAlert = "Riducendo questa cifra al di sotto di %2 tutte le informazioni relative a %1 verranno eliminate.";
   italianStrings.securityMsg = "%1 sta tentando di leggere da %2. Questa operazione è potenzialmente pericolosa. Si desidera consentirla?";
   italianStrings.securityRemember = "Non chiedere più";
   italianStrings.Current = "Attualmente in uso:";
   italianStrings.waitMsg = "Rilevamento videocamere in corso...";
   italianStrings.noCam = "Nessuna videocamera trovata.";
   italianStrings.storageError = "Non è stato possibile eliminare tutti i dati archiviati.";
   italianStrings.Advanced = "Avanzato";
   italianStrings.local = "locale";
   italianStrings.videoSafe = "Abilita accelerazione hardware";
   italianStrings.installerTitle = "Adobe Flash";
   italianStrings.installerConnecting = "Connessione...";
   italianStrings.DP_error_1 = inputState.name;
   italianStrings.DP_error_2 = "Si  è verificato un errore di scaricamento. Scaricare di nuovo?";
   italianStrings.DP_error_3 = "Impossibile scrivere l\'applicazione sul disco rigido. Controllare se il disco rigido è disponibile e ritentare";
   italianStrings.kb = "KB";
   japaneseStrings = new Object();
   japaneseStrings.titles = new Array("プライバシー","ローカルストレージ","マイク","カメラ","スクリーン共有を開始","セキュリティ","カメラとマイクへのアクセス","表示","ピアアシストネットワーク");
   japaneseStrings.storageLevels = new Array({label:"禁止",value:-1},{label:"なし",value:0},{label:"10 KB",value:10},{label:"100 KB",value:100},{label:"1 MB",value:1024},{label:"10 MB",value:10240},{label:"制限しない",value:-2});
   japaneseStrings.available = new Array(0,10,100,1024,10240,-2);
   japaneseStrings.displayAs = new Array("0 KB","10 KB","100 KB","1 MB","10 MB","制限しない");
   japaneseStrings.windowTitle = "Adobe Flash Player 設定";
   japaneseStrings.Close = "閉じる";
   japaneseStrings.Yes = "はい";
   japaneseStrings.No = "いいえ";
   japaneseStrings.Allow = "許可";
   japaneseStrings.OK = "OK";
   japaneseStrings.Cancel = "キャンセル";
   japaneseStrings.Deny = "拒否";
   japaneseStrings.Retry = "再試行";
   japaneseStrings.Never = "今後表示しない";
   japaneseStrings.Remember = "設定を保存";
   japaneseStrings.Volume = "録音ボリューム :";
   japaneseStrings.Echo = "エコーを減らす";
   japaneseStrings.PrivacyMsgText = "%1 のカメラおよびマイクへのアクセスを許可しますか ?";
   japaneseStrings.PrivacyPopMsgText = "%1 がカメラとマイクへのアクセスを要求しています。[許可] をクリックすると、録音が許可されます。";
   japaneseStrings.ScreenPrivacyMsgText = "%1 にご使用のコンピューターのスクリーン共有を許可しますか?";
   japaneseStrings.P2PPrivacyMsgText = "%1 でピアアシストネットワークを使用できます。アップロード帯域幅へのアクセスを許可しますか？";
   japaneseStrings.StorageMsgText = "%1 がコンピューターに保存できる情報量";
   japaneseStrings.popUp_StorageText = "%1 はコンピューターに情報を保存する許可を要求しています。";
   japaneseStrings.popUp_StorageData = "リクエスト容量: 最大 %2<br>使用中の容量: %3";
   japaneseStrings.storageAlert = "%2 以下にすると、%1 のすべての情報が削除される可能性があります。";
   japaneseStrings.securityMsg = "%1 は %2 からの読み取りを試みています。この操作はセキュリティで保護されない可能性があります。許可しますか?";
   japaneseStrings.securityRemember = "今後表示しない";
   japaneseStrings.Current = "現在使用中 :";
   japaneseStrings.waitMsg = "カメラを検知しています...";
   japaneseStrings.noCam = "カメラがありません。";
   japaneseStrings.storageError = "一部のデータを削除できませんでした。";
   japaneseStrings.Advanced = "高度な設定";
   japaneseStrings.local = "ローカル";
   japaneseStrings.videoSafe = "ハードウェアアクセラレーションを有効化";
   japaneseStrings.installerTitle = "Adobe Flash";
   japaneseStrings.installerConnecting = "接続中...";
   japaneseStrings.DP_error_1 = inputState.name;
   japaneseStrings.DP_error_2 = "ダウンロードエラーが発生しました。ダウンロードを再び行いますか？";
   japaneseStrings.DP_error_3 = "アプリケーションをハードディスクに書き込めませんでした。ハードディスクに空き容量があるか確認し、もう一度お試しください。";
   japaneseStrings.kb = "KB";
   koreanStrings = new Object();
   koreanStrings.titles = new Array("개인 정보 보호","로컬 저장소","마이크","카메라","시작 화면 공유","보안","카메라 및 마이크 액세스","디스플레이","피어 지원 네트워킹");
   koreanStrings.storageLevels = new Array({label:"안함",value:-1},{label:"없음",value:0},{label:"10 KB",value:10},{label:"100 KB",value:100},{label:"1 MB",value:1024},{label:"10 MB",value:10240},{label:"제한 없음",value:-2});
   koreanStrings.available = new Array(0,10,100,1024,10240,-2);
   koreanStrings.displayAs = new Array("0 KB","10 KB","100 KB","1 MB","10 MB","무제한");
   koreanStrings.windowTitle = "Adobe Flash Player 설정";
   koreanStrings.Close = "닫기";
   koreanStrings.Yes = "예";
   koreanStrings.No = "아니요";
   koreanStrings.Allow = "허용";
   koreanStrings.OK = "확인";
   koreanStrings.Cancel = "취소";
   koreanStrings.Deny = "거부";
   koreanStrings.Retry = "재시도";
   koreanStrings.Never = "다시 묻지 않음";
   koreanStrings.Remember = "기억";
   koreanStrings.Volume = "녹음 볼륨:";
   koreanStrings.Echo = "반향 줄이기";
   koreanStrings.PrivacyMsgText = "%1이(가) 웹캠과 마이크에 액세스하도록 허용하시겠습니까?";
   koreanStrings.PrivacyPopMsgText = "%1 에서 카메라 및 마이크에 액세스하려고 합니다. [허용]을 클릭하면 녹화 또는 녹음될 수 있습니다.";
   koreanStrings.ScreenPrivacyMsgText = "%1이(가) 컴퓨터 화면을 공유하도록 허용하시겠습니까?";
   koreanStrings.P2PPrivacyMsgText = "%1에서 피어 지원 네트워킹을 사용할 수 있습니다. 업로드 대역폭에 대한 액세스를 허용하시겠습니까?";
   koreanStrings.StorageMsgText = "%1에 할당할 저장 공간을 지정하십시오.";
   koreanStrings.popUp_StorageText = "%1에서 컴퓨터에 대한 정보 저장 권한을 요청하고 있습니다.";
   koreanStrings.popUp_StorageData = "요구량: 최대 %2<br>현재 사용량: %3";
   koreanStrings.storageAlert = "사용량이 %2 이하로 감소하면 %1에 대한 정보가 모두 제거됩니다.";
   koreanStrings.securityMsg = "%1이(가) %2에서 읽기를 시도하고 있습니다. 이 작업은 보안에 위배됩니다. 허용하시겠습니까?";
   koreanStrings.securityRemember = "다시 묻지 않음";
   koreanStrings.Current = "현재 사용량:";
   koreanStrings.waitMsg = "웹캠 검색 중…";
   koreanStrings.noCam = "웹캠을 찾을 수 없습니다.";
   koreanStrings.storageError = "저장된 데이터가 모두 제거되지 않을 수 있습니다.";
   koreanStrings.Advanced = "고급";
   koreanStrings.local = "로컬";
   koreanStrings.videoSafe = "하드웨어 가속 사용";
   koreanStrings.installerTitle = "Adobe Flash";
   koreanStrings.installerConnecting = "연결 중...";
   koreanStrings.DP_error_1 = inputState.name;
   koreanStrings.DP_error_2 = "다운로드 에러가 발생했습니다. 다시 다운로드 하시겠습니까?";
   koreanStrings.DP_error_3 = "애플리케이션을 하드 디스크에 쓰지 못합니다. 하드 디스크가 사용 가능한지 확인하시고 다시 시도해 보십시오.";
   koreanStrings.kb = "KB";
   spanishStrings = new Object();
   spanishStrings.titles = new Array("Privacidad","Almacenamiento local","Micrófono","Cámara","Iniciar compartición de pantalla","Seguridad","Acceso a cámara y micrófono","Visualización","Redes asistidas por pares");
   spanishStrings.storageLevels = new Array({label:"Nunca",value:-1},{label:"Ninguno",value:0},{label:"10 KB",value:10},{label:"100 KB",value:100},{label:"1 MB",value:1024},{label:"10 MB",value:10240},{label:"Ilimitado",value:-2});
   spanishStrings.available = new Array(0,10,100,1024,10240,-2);
   spanishStrings.displayAs = new Array("0 KB","10 KB","100 KB","1 MB","10 MB","ilimitado");
   spanishStrings.windowTitle = "Configuración de Adobe Flash Player";
   spanishStrings.Close = "Cerrar";
   spanishStrings.Yes = "Sí";
   spanishStrings.No = "No";
   spanishStrings.Allow = "Permitir";
   spanishStrings.OK = "Aceptar";
   spanishStrings.Cancel = "Cancelar";
   spanishStrings.Deny = "Denegar";
   spanishStrings.Retry = "Reintentar";
   spanishStrings.Never = "Nunca";
   spanishStrings.Remember = "Recordar";
   spanishStrings.Volume = "Volumen de registro:";
   spanishStrings.Echo = "Reducir eco";
   spanishStrings.PrivacyMsgText = "¿Desea que %1 pueda acceder a la cámara y al micrófono?";
   spanishStrings.PrivacyPopMsgText = "%1 solicita el acceso a su cámara y micrófono. Si hace clic en Permitir, podrá ser grabado.";
   spanishStrings.ScreenPrivacyMsgText = "¿Desea permitir que %1 comparta su pantalla?";
   spanishStrings.P2PPrivacyMsgText = "%1 puede usar redes asistidas por pares. ¿Desea permitir acceso al ancho de banda de carga?";
   spanishStrings.StorageMsgText = "¿Cuánta información puede almacenar %1 en su PC?";
   spanishStrings.popUp_StorageText = "%1 solicita autorización para almacenar información en su PC.";
   spanishStrings.popUp_StorageData = "Solicitado: hasta %2<br>Actualmente usado: %3";
   spanishStrings.storageAlert = "Si disminuye a menos de %2 se quitará toda la información para %1.";
   spanishStrings.securityMsg = "%1 está intentando leer de %2. Esta operación podría no ser segura. ¿Desea permitirla?";
   spanishStrings.securityRemember = "No volver a preguntar";
   spanishStrings.Current = "Actualmente usado:";
   spanishStrings.waitMsg = "Detectando cámaras...";
   spanishStrings.noCam = "No se ha encontrado ninguna cámara.";
   spanishStrings.storageError = "No se pudieron quitar todos los datos almacenados.";
   spanishStrings.Advanced = "Avanzado";
   spanishStrings.local = "local";
   spanishStrings.videoSafe = "Activar aceleración de hardware";
   spanishStrings.installerTitle = "Adobe Flash";
   spanishStrings.installerConnecting = "Conectando...";
   spanishStrings.DP_error_1 = inputState.name;
   spanishStrings.DP_error_2 = "Error al descargar. ¿Desea volver a intentarlo?";
   spanishStrings.DP_error_3 = "No se pudo grabar la aplicacin en el disco duro. Compruebe el disco duro disponible y vuelva a intentarlo.";
   spanishStrings.kb = "KB";
   csStrings = new Object();
   csStrings.titles = new Array("Ochrana osobních údajů","Místní úložiště","Mikrofon","Kamera","Spustit sdílení obrazovky","Zabezpečení","Přístup ke kameře a mikrofonu","Zobrazení","Sítě peer-assisted");
   csStrings.storageLevels = new Array({label:"Nikdy",value:-1},{label:"Žádné",value:0},{label:"10 kB",value:10},{label:"100 kB",value:100},{label:"1 MB",value:1024},{label:"10 MB",value:10240},{label:"Neomezeno",value:-2});
   csStrings.available = new Array(0,10,100,1024,10240,-2);
   csStrings.displayAs = new Array("0 kB","10 kB","100 kB","1 MB","10 MB","Neomezeno");
   csStrings.windowTitle = "Nastavení pro Adobe Flash Player";
   csStrings.Close = "Zavřít";
   csStrings.Yes = "Ano";
   csStrings.No = "Ne";
   csStrings.Allow = "Povolit";
   csStrings.OK = "OK";
   csStrings.Cancel = "Zrušit";
   csStrings.Deny = "Odmítnout";
   csStrings.Retry = "Zkusit znovu";
   csStrings.Never = "Znovu se nedotazovat";
   csStrings.Remember = "Zapamatovat";
   csStrings.Volume = "Hlasitost nahrávání:";
   csStrings.Echo = "Potlačit odezvu";
   csStrings.PrivacyMsgText = "Povolit %1 přístup k vaší kameře a mikrofonu?";
   csStrings.PrivacyPopMsgText = "%1 požaduje přístup k vaší kameře a mikrofonu. Pokud klepnete na tlačítko Povolit, můžete být nahráváni.";
   csStrings.ScreenPrivacyMsgText = "Povolit %1 sdílet obrazovku vašeho počítače?";
   csStrings.P2PPrivacyMsgText = "%1 smí používat sítě peer-assisted. Chcete povolit přístup k odchozím přenosovým možnostem?";
   csStrings.StorageMsgText = "Jaké množství informací může %1 uložit na váš počítač?";
   csStrings.popUp_StorageText = "%1 požaduje povolení k uložení informací do vašeho počítače.";
   csStrings.popUp_StorageData = "Požadováno: až %2<br>Právě používáno: %3";
   csStrings.storageAlert = "Snížení množství pod hodnotu %2 způsobí odstranění všech informací pro %1.";
   csStrings.securityMsg = "%1 se pokouší číst z %2. Jedná se o potenciálně nebezpečnou operaci. Chcete to povolit?";
   csStrings.securityRemember = "Znovu se nedotazovat";
   csStrings.Current = "Používáno:";
   csStrings.waitMsg = "Probíhá detekování kamer...";
   csStrings.noCam = "Nelze najít kameru";
   csStrings.storageError = "Ne všechna uložená data lze odstranit.";
   csStrings.Advanced = "Další volby";
   csStrings.local = "místní";
   csStrings.videoSafe = "Zapnout hardwarovou akceleraci";
   csStrings.installerTitle = "Adobe Flash";
   csStrings.installerConnecting = "Připojování...";
   csStrings.DP_error_1 = inputState.name;
   csStrings.DP_error_2 = "Při stahování došlo k chybě. Chcete stahování zkusit znovu?";
   csStrings.DP_error_3 = "Nelze zapsat aplikaci na pevný disk. Zkontrolujte prosím, zda je pevný disk dostupný, a zkuste to znovu.";
   csStrings.kb = "kB";
   nlStrings = new Object();
   nlStrings.titles = new Array("Privacy","Lokale opslag","Microfoon","Camera","Scherm delen starten","Beveiliging","Toegang tot camera en microfoon","Weergave","Peer-ondersteund netwerken");
   nlStrings.storageLevels = new Array({label:"Nooit",value:-1},{label:"Geen",value:0},{label:"10 kB",value:10},{label:"100 KB",value:100},{label:"1 MB",value:1024},{label:"10 MB",value:10240},{label:"Onbeperkt",value:-2});
   nlStrings.available = new Array(0,10,100,1024,10240,-2);
   nlStrings.displayAs = new Array("0 kB","10 kB","100 kB","1 MB","10 MB","onbeperkt");
   nlStrings.windowTitle = "Instellingen Adobe Flash Player";
   nlStrings.Close = "Sluiten";
   nlStrings.Yes = "Ja";
   nlStrings.No = "Nee";
   nlStrings.Allow = "Toestaan";
   nlStrings.OK = "OK";
   nlStrings.Cancel = "Annuleren";
   nlStrings.Deny = "Weigeren";
   nlStrings.Retry = "Opnieuw";
   nlStrings.Never = "Niet meer vragen";
   nlStrings.Remember = "Onthoud";
   nlStrings.Volume = "Opnamevolume:";
   nlStrings.Echo = "Echo beperken";
   nlStrings.PrivacyMsgText = "%1 toegang verlenen tot uw camera en microfoon?";
   nlStrings.PrivacyPopMsgText = "%1 vraagt toegang tot uw camera en microfoon. Als u op Toestaan klikt, wordt u mogelijk opgenomen.";
   nlStrings.ScreenPrivacyMsgText = "%1 toestaan ook gebruik van uw computerscherm te maken?";
   nlStrings.P2PPrivacyMsgText = "%1 kan peer-ondersteund netwerken gebruiken. Wilt u toegang tot uw uploadbandbreedte toestaan?";
   nlStrings.StorageMsgText = "Hoeveel informatie kan %1 opslaan op uw computer?";
   nlStrings.popUp_StorageText = "%1 vraagt toestemming om gegevens op uw computer op te slaan.";
   nlStrings.popUp_StorageData = "Gevraagd: tot %2<br>Momenteel gebruikt: %3";
   nlStrings.storageAlert = "Wanneer u de hoeveelheid verlaagt tot minder dan %2, wordt alle informatie voor %1 verwijderd.";
   nlStrings.securityMsg = "%1 probeert te lezen van %2. Dit is een potentieel onveilige bewerking. Wilt u dit toestaan?";
   nlStrings.securityRemember = "Nooit meer vragen";
   nlStrings.Current = "In gebruik:";
   nlStrings.waitMsg = "Bezig met detecteren van camera\'s...";
   nlStrings.noCam = "Kan geen camera vinden";
   nlStrings.storageError = "Niet alle opgeslagen gegevens kunnen worden verwijderd.";
   nlStrings.Advanced = "Geavanceerd";
   nlStrings.local = "lokaal";
   nlStrings.videoSafe = "Hardwareversnelling inschakelen";
   nlStrings.installerTitle = "Adobe Flash";
   nlStrings.installerConnecting = "Bezig met verbinding maken...";
   nlStrings.DP_error_1 = inputState.name;
   nlStrings.DP_error_2 = "Er is een downloadfout opgetreden. Downloaden opnieuw proberen?";
   nlStrings.DP_error_3 = "Kan de toepassing niet naar de vaste schijf schrijven. Controleer of de vaste schijf beschikbaar is en probeer het opnieuw.";
   nlStrings.kb = "kB";
   plStrings = new Object();
   plStrings.titles = new Array("Prywatność","Magazyn lokalny","Mikrofon","Kamera","Rozpocznij udostępnianie ekranu","Zabezpieczenia","Dostęp do kamery i mikrofonu","Wyświetlacz","Sieć ze wspomaganiem równorzędnym");
   plStrings.storageLevels = new Array({label:"Nowszy",value:-1},{label:"Brak",value:0},{label:"10 KB",value:10},{label:"100 KB",value:100},{label:"1 MB",value:1024},{label:"10 MB",value:10240},{label:"Bez ograniczeń",value:-2});
   plStrings.available = new Array(0,10,100,1024,10240,-2);
   plStrings.displayAs = new Array("0 KB","10 KB","100 KB","1 MB","10 MB","Bez ograniczeń");
   plStrings.windowTitle = "Ustawienia programu Adobe Flash Player";
   plStrings.Close = "Zamknij";
   plStrings.Yes = "Tak";
   plStrings.No = "Nie";
   plStrings.Allow = "Zezwól";
   plStrings.OK = "OK";
   plStrings.Cancel = "Anuluj";
   plStrings.Deny = "Odmów";
   plStrings.Retry = "Ponów próbę";
   plStrings.Never = "Nie pytaj ponownie";
   plStrings.Remember = "Zapamiętaj";
   plStrings.Volume = "Głośność nagrywania:";
   plStrings.Echo = "Zmniejsz echo";
   plStrings.PrivacyMsgText = "Czy %1 może uzyskać dostęp do kamery i mikrofonu?";
   plStrings.PrivacyPopMsgText = "Strona %1 prosi o dostęp do kamery i mikrofonu. Kliknięcie przycisku Zezwól umożliwi innym nagrywanie dźwięku i obrazu za pomocą urządzeń.";
   plStrings.ScreenPrivacyMsgText = "Czy %1 może współużytkować ekran komputera?";
   plStrings.P2PPrivacyMsgText = "%1 może używać sieci ze wspomaganiem równorzędnym. Czy chcesz zezwolić na używanie swojej przepustowości wysyłania?";
   plStrings.StorageMsgText = "Jak dużo danych %1 może przechowywać na komputerze?";
   plStrings.popUp_StorageText = "Strona %1 prosi o przyzwolenie na przechowywanie informacji na komputerze.";
   plStrings.popUp_StorageData = "Żądane: do %2<br>Obecnie używane: %3";
   plStrings.storageAlert = "Zmniejszenie ilości poniżej %2 spowoduje, że wszystkie informacje dotyczące %1 zostaną usunięte.";
   plStrings.securityMsg = "%1 próbuje odczytać %2. Ta operacja jest potencjalnie niebezpieczna. Czy zgadzasz się na nią?";
   plStrings.securityRemember = "Nie pytaj ponownie";
   plStrings.Current = "Używane:";
   plStrings.waitMsg = "Wykrywanie kamer...";
   plStrings.noCam = "Nie można znaleźć kamery.";
   plStrings.storageError = "Nie można usunąć wszystkich przechowywanych danych.";
   plStrings.Advanced = "Zaawansowane";
   plStrings.local = "lokalny";
   plStrings.videoSafe = "Włącz przyspieszanie sprzętowe";
   plStrings.installerTitle = "Adobe Flash";
   plStrings.installerConnecting = "Łączenie...";
   plStrings.DP_error_1 = inputState.name;
   plStrings.DP_error_2 = "Wystąpił błąd pobierania. Spróbować pobrać ponownie?";
   plStrings.DP_error_3 = "Nie można zapisać aplikacji na dysku twardym. Sprawdź dostępność dysku twardego i spróbuj ponownie.";
   plStrings.kb = "KB";
   ptStrings = new Object();
   ptStrings.titles = new Array("Privacidade","Armazenamento local","Microfone","Câmera","Iniciar compartilhamento de tela","Segurança","Acesso a câmera e microfone","Exibição","Sistema de redes de pares");
   ptStrings.storageLevels = new Array({label:"Nunca",value:-1},{label:"Nenhum",value:0},{label:"10 KB",value:10},{label:"100 KB",value:100},{label:"1 MB",value:1024},{label:"10 MB",value:10240},{label:"Ilimitado",value:-2});
   ptStrings.available = new Array(0,10,100,1024,10240,-2);
   ptStrings.displayAs = new Array("0 KB","10 KB","100 KB","1 MB","10 MB","ilimitado");
   ptStrings.windowTitle = "Configurações do Adobe Flash Player";
   ptStrings.Close = "Fechar";
   ptStrings.Yes = "Sim";
   ptStrings.No = "Não";
   ptStrings.Allow = "Permitir";
   ptStrings.OK = "OK";
   ptStrings.Cancel = "Cancelar";
   ptStrings.Deny = "Negar";
   ptStrings.Retry = "Repetir";
   ptStrings.Never = "Não perguntar de novo";
   ptStrings.Remember = "Lembrar";
   ptStrings.Volume = "Volume da gravação:";
   ptStrings.Echo = "Reduzir eco";
   ptStrings.PrivacyMsgText = "Permitir que %1 acesse a câmera e o microfone?";
   ptStrings.PrivacyPopMsgText = "%1 está solicitando acesso à câmera e ao microfone. Se você clicar em Permitir, sua comunicação pode ser gravada.";
   ptStrings.ScreenPrivacyMsgText = "Permitir que %1 compartilhe a tela do computador?";
   ptStrings.P2PPrivacyMsgText = "%1 pode usar sistema de redes de pares. Deseja permitir acesso à sua largura de banda de carregamento?";
   ptStrings.StorageMsgText = "Qual quantidade de informações %1 pode armazenar no computador?";
   ptStrings.popUp_StorageText = "%1 está solicitando permissão para armazenar informações no computador.";
   ptStrings.popUp_StorageData = "Solicitado: até %2<br>Em uso no momento: %3";
   ptStrings.storageAlert = "Diminuir o valor para menos de %2 fará com que todas as informações de %1 sejam removidas.";
   ptStrings.securityMsg = "%1 está tentando ler de %2. Trata-se de uma operação potencialmente insegura. Deseja permiti-la?";
   ptStrings.securityRemember = "Nunca perguntar de novo";
   ptStrings.Current = "Uso atual:";
   ptStrings.waitMsg = "Detectando câmeras...";
   ptStrings.noCam = "Não é possível encontrar a câmera";
   ptStrings.storageError = "Não foi possível remover todos os dados armazenados.";
   ptStrings.Advanced = "Avançado";
   ptStrings.local = "local";
   ptStrings.videoSafe = "Habilitar aceleração de hardware";
   ptStrings.installerTitle = "Adobe Flash";
   ptStrings.installerConnecting = "Conectando...";
   ptStrings.DP_error_1 = inputState.name;
   ptStrings.DP_error_2 = "Erro de download. Deseja repetir o download?";
   ptStrings.DP_error_3 = "Não foi possível gravar o aplicativo no disco rígido. Verifique se o disco rígido está disponível e tente novamente.";
   ptStrings.kb = "KB";
   ruStrings = new Object();
   ruStrings.titles = new Array("Конфиденциальность","Локальное хранилище","Микрофон","Камера","Начать совместное использование экрана","Безопасность","Доступ к камере и микрофону","Отображение","Пиринговая сеть");
   ruStrings.storageLevels = new Array({label:"Никогда",value:-1},{label:"Отсутствует",value:0},{label:"10 КБ",value:10},{label:"100 КБ",value:100},{label:"1 МБ",value:1024},{label:"10 МБ",value:10240},{label:"Без ограничений",value:-2});
   ruStrings.available = new Array(0,10,100,1024,10240,-2);
   ruStrings.displayAs = new Array("0 КБ","10 КБ","100 КБ","1 МБ","10 МБ","Без ограничений");
   ruStrings.windowTitle = "Параметры Adobe Flash Player";
   ruStrings.Close = "Закрыть";
   ruStrings.Yes = "Да";
   ruStrings.No = "Нет";
   ruStrings.Allow = "Разрешить";
   ruStrings.OK = "OK";
   ruStrings.Cancel = "Отмена";
   ruStrings.Deny = "Запретить";
   ruStrings.Retry = "Повторить";
   ruStrings.Never = "не спрашивать";
   ruStrings.Remember = "Запомнить";
   ruStrings.Volume = "Громкость записи:";
   ruStrings.Echo = "Уменьшить эхо";
   ruStrings.PrivacyMsgText = "Разрешить %1 доступ к вашим камере и микрофону?";
   ruStrings.PrivacyPopMsgText = "%1 запрашивает доступ к вашим камере и микрофону. Если нажать \"Разрешить\", то вас могут записывать.";
   ruStrings.ScreenPrivacyMsgText = "Разрешить %1 совместное пользование монитором компьютера?";
   ruStrings.P2PPrivacyMsgText = "%1 может использовать пиринговую сеть. Хотите получить доступ к своей полосе пропускания загрузки?";
   ruStrings.StorageMsgText = "Какой объем информации %1 может хранить на вашем компьютере?";
   ruStrings.popUp_StorageText = "%1 запрашивает разрешение на хранение информации на вашем компьютере.";
   ruStrings.popUp_StorageData = "Требуется: до %2<br>В данный момент используется: %3";
   ruStrings.storageAlert = "Уменьшение объема ниже %2 приведет к удалению всей информации для %1.";
   ruStrings.securityMsg = "%1 пытается читать из %2. Это потенциально небезопасная операция. Разрешить эту операцию?";
   ruStrings.securityRemember = "Больше не задавать этот вопрос";
   ruStrings.Current = "Сейчас:";
   ruStrings.waitMsg = "Обнаружение камер…";
   ruStrings.noCam = "Не удалось найти камеру";
   ruStrings.storageError = "Не все хранящиеся данные можно удалить.";
   ruStrings.Advanced = "Дополнит";
   ruStrings.local = "локальный";
   ruStrings.videoSafe = "Включить аппаратное ускорение";
   ruStrings.installerTitle = "Adobe Flash";
   ruStrings.installerConnecting = "Подключение...";
   ruStrings.DP_error_1 = inputState.name;
   ruStrings.DP_error_2 = "Ошибка при загрузке. Попробовать загрузить еще раз?";
   ruStrings.DP_error_3 = "Не удалось записать приложение на жесткий диск. Убедитесь, что жесткий диск доступен, и повторите попытку.";
   ruStrings.kb = "КБ";
   svStrings = new Object();
   svStrings.titles = new Array("Sekretess","Lokalt lagringsutrymme","Mikrofon","Kamera","Starta skärmdelning","Säkerhet","Åtkomst till kamera och mikrofon","Visning","P2P-nätverk");
   svStrings.storageLevels = new Array({label:"Aldrig",value:-1},{label:"Ingen",value:0},{label:"10 kB",value:10},{label:"100 kB",value:100},{label:"1 MB",value:1024},{label:"10 MB",value:10240},{label:"Obegränsat",value:-2});
   svStrings.available = new Array(0,10,100,1024,10240,-2);
   svStrings.displayAs = new Array("0 kB","10 kB","100 kB","1 MB","10 MB","obegränsat");
   svStrings.windowTitle = "Adobe Flash Player-inställningar";
   svStrings.Close = "Stäng";
   svStrings.Yes = "Ja";
   svStrings.No = "Nej";
   svStrings.Allow = "Tillåt";
   svStrings.OK = "OK";
   svStrings.Cancel = "Avbryt";
   svStrings.Deny = "Neka";
   svStrings.Retry = "Försök igen";
   svStrings.Never = "Fråga inte igen";
   svStrings.Remember = "Kom ihåg";
   svStrings.Volume = "Inspelningsvolym:";
   svStrings.Echo = "Minska eko";
   svStrings.PrivacyMsgText = "Ska %1 få åtkomst till din kamera och mikrofon?";
   svStrings.PrivacyPopMsgText = "%1 begär åtkomst till din kamera och mikrofon. Om du klickar på Tillåt kan du bli inspelad.";
   svStrings.ScreenPrivacyMsgText = "Ska %1 få dela din datorskärm?";
   svStrings.P2PPrivacyMsgText = "%1 kanske använder P2P-nätverk. Tillåter du åtkomst till din bandbredd för uppladdning?";
   svStrings.StorageMsgText = "Hur mycket information får %1 lagra på datorn?";
   svStrings.popUp_StorageText = "%1 begär behörighet att lagra information på din dator.";
   svStrings.popUp_StorageData = "Begärt: upp till %2<br>Används för närvarande: %3";
   svStrings.storageAlert = "Om du minskar mängden till under %2 tas all information för %1 bort.";
   svStrings.securityMsg = "%1 försöker läsa från %2. Den här åtgärden kan vara osäker. Vill du tillåta den?";
   svStrings.securityRemember = "Fråga inte igen";
   svStrings.Current = "Används nu:";
   svStrings.waitMsg = "Identifierar kameror...";
   svStrings.noCam = "Det går inte att hitta kameran";
   svStrings.storageError = "Det gick inte att ta bort alla lagrade data.";
   svStrings.Advanced = "Avancerat";
   svStrings.local = "lokal";
   svStrings.videoSafe = "Aktivera maskinvaruacceleration";
   svStrings.installerTitle = "Adobe Flash";
   svStrings.installerConnecting = "Ansluter...";
   svStrings.DP_error_1 = inputState.name;
   svStrings.DP_error_2 = "Ett hämtningsfel har uppstått. Vill du hämta på nytt?";
   svStrings.DP_error_3 = "Det gick inte att skriva programmet till hårddisken. Kontrollera att hårddisken är tillgänglig och försök igen.";
   svStrings.kb = "kB";
   trStrings = new Object();
   trStrings.titles = new Array("Gizlilik","Yerel Depolama","Mikrofon","Kamera","Başlangıç Ekran Paylaşımı","Güvenlik","Kamera ve Mikrofon Erişimi","Görüntü","Eş Destekli Ağ İletişimi");
   trStrings.storageLevels = new Array({label:"Hiçbir zaman",value:-1},{label:"Yok",value:0},{label:"10 KB",value:10},{label:"100 KB",value:100},{label:"1 MB",value:1024},{label:"10 MB",value:10240},{label:"Sınırsız",value:-2});
   trStrings.available = new Array(0,10,100,1024,10240,-2);
   trStrings.displayAs = new Array("0 KB","10 KB","100 KB","1 MB","10 MB","Sınırsız");
   trStrings.windowTitle = "Adobe Flash Player Ayarları";
   trStrings.Close = "Kapat";
   trStrings.Yes = "Evet";
   trStrings.No = "Hayır";
   trStrings.Allow = "İzin Ver";
   trStrings.OK = "Tamam";
   trStrings.Cancel = "İptal";
   trStrings.Deny = "Reddet";
   trStrings.Retry = "Yeniden Dene";
   trStrings.Never = "Tekrar Sorma";
   trStrings.Remember = "Anımsa";
   trStrings.Volume = "Kayıt Sesi:";
   trStrings.Echo = "Ekoyu Azalt";
   trStrings.PrivacyMsgText = "%1 kaynağının fotoğraf makinenize ve mikrofonunuza erişmesine izin verilsin mi?";
   trStrings.PrivacyPopMsgText = "%1, kamera ve mikrofonunuza erişim istiyor. İzin Ver\'i tıklatırsanız görüntünüz ve sesiniz kaydedilebilir.";
   trStrings.ScreenPrivacyMsgText = "%1 kaynağının bilgisayar ekranınızı paylaşmasına izin verilsin mi?";
   trStrings.P2PPrivacyMsgText = "%1, eş destekli ağ iletişimi kullanabilir. Yükleme bant genişliğinize erişim vermek istiyor musunuz?";
   trStrings.StorageMsgText = "%1 bilgisayarınıza ne kadar bilgi depolayabilir?";
   trStrings.popUp_StorageText = "%1, bilgisayarınıza bilgi depolamak için izin istiyor.";
   trStrings.popUp_StorageData = "İstenen: En fazla %2<br>Şu Anda Kullanılan: %3";
   trStrings.storageAlert = "Miktarın %2 altına düşürülmesi, %1 öğesine yönelik tüm bilgilerin kaldırılmasına neden olur.";
   trStrings.securityMsg = "%1, %2 kaynağından okumaya çalışıyor. Bu işlem güvenli olmayabilir. İzin vermek istiyor musunuz?";
   trStrings.securityRemember = "Bir daha asla sorma";
   trStrings.Current = "Kullanılan:";
   trStrings.waitMsg = "Kameralar algılanıyor...";
   trStrings.noCam = "Kamera bulunamıyor";
   trStrings.storageError = "Depolanmış verilerin tümü kaldırılamadı.";
   trStrings.Advanced = "Gelişmiş";
   trStrings.local = "local";
   trStrings.videoSafe = "Donanım hızlandırma özelliğini etkinleştir";
   trStrings.installerTitle = "Adobe Flash";
   trStrings.installerConnecting = "Bağlanıyor...";
   trStrings.DP_error_1 = inputState.name;
   trStrings.DP_error_2 = "İndirme hatası oluştu. Yeniden indirmeyi dene?";
   trStrings.DP_error_3 = "Uygulama sabit diske yazılamadı. Lütfen sabit diskin kullanılabilir durumda olduğunu doğrulayın ve yeniden deneyin.";
   trStrings.kb = "KB";
   _global.lang = System.capabilities.language;
   out.text += "begin " + lang + "\n";
   kb = "KB";
   switch(lang)
   {
      case "en-US":
         language = "english_us";
         myStyle = "defStyle";
         break;
      case "cs":
         language = "cs";
         myStyle = "defStyle";
         break;
      case "nl":
         language = "nl";
         myStyle = "defStyle";
         break;
      case "pl":
         language = "pl";
         myStyle = "defStyle";
         break;
      case "pt":
      case "pt-BR":
         language = "pt";
         myStyle = "defStyle";
         break;
      case "ru":
         language = "ru";
         myStyle = "defStyle";
         break;
      case "sv":
         language = "sv";
         myStyle = "defStyle";
         break;
      case "tr":
         language = "tr";
         myStyle = "defStyle";
         break;
      case "de":
         language = "german";
         myStyle = "defStyle";
         break;
      case "fr":
         kb = "Ko";
         language = "french";
         myStyle = "defStyle";
         break;
      case "zh-TW":
         language = "CHT";
         myStyle = "altStyle";
         break;
      case "zh-CN":
         language = "CHS";
         myStyle = "altStyle";
         break;
      case "ja":
         language = "japanese";
         myStyle = "altStyle";
         break;
      case "ko":
         language = "korean";
         myStyle = "altStyle";
         break;
      case "it":
         language = "italian";
         myStyle = "defStyle";
         break;
      case "es":
         language = "spanish";
         myStyle = "defStyle";
         break;
      default:
         language = "english_us";
         myStyle = "defStyle";
   }
   ls = eval(language + "Strings");
   if(ls.installerConnecting === undefined)
   {
      ls.installerConnecting = english_usStrings.installerConnecting;
   }
   kb = ls.kb;
   rads = new Object();
   itabs = new Array();
   foundCams = false;
   windowTitle.text = ls.windowTitle;
   setStyle(windowTitle);
   Close.label.text = ls.Close;
   setStyle(Close.label);
   block._width = 4000;
   block._height = 4000;
   if(inputState.isPrivate)
   {
      microphoneSettings._x = privacy._x;
      cameraSettings._x = localinformation._x;
      privacy._visible = false;
      localinformation._visible = false;
   }
}
function setStyle(field)
{
   if(myStyle == "altStyle")
   {
      fSize = 11;
   }
   else
   {
      fSize = 10;
   }
   theStyle = new TextFormat();
   theStyle.size = fSize;
   field.setTextFormat(theStyle);
}
function killHand()
{
   for(i in myRoot)
   {
      if(myRoot[i] instanceof Button || myRoot[i] instanceof MovieClip)
      {
         myRoot[i].useHandCursor = false;
      }
   }
   cameraSettings._visible = System.capabilities.hasVideoEncoder;
   microphoneSettings._visible = System.capabilities.hasAudioEncoder;
   if(inputState.isPrivate)
   {
      privacy._visible = false;
   }
   else
   {
      privacy._visible = System.capabilities.hasAudioEncoder || System.capabilities.hasVideoEncoder;
   }
}
function checkMode()
{
   if(inputState.Mode == 0)
   {
      gotoAndStop("_dispatch");
   }
   else if(inputState.Mode == 1)
   {
      gotoAndStop("pop_storage");
   }
   else if(inputState.Mode == 2)
   {
      gotoAndStop("pop_privacy");
   }
   else if(inputState.Mode == 3)
   {
      gotoAndStop("DP_init");
   }
   else if(inputState.Mode == 4)
   {
      gotoAndStop("pop_screenshare");
   }
   else if(inputState.Mode == 5)
   {
      gotoAndStop("pop_crossdomain");
   }
   else if(inputState.Mode == 7)
   {
      gotoAndStop("pop_p2p");
   }
}
function getAppropriateLevel(kc)
{
   var _loc2_ = -2;
   i = 0;
   while(i < ls.storageLevels.length)
   {
      if(kc <= ls.storageLevels[i].value && kc != -2)
      {
         _loc2_ = ls.storageLevels[i].value;
         break;
      }
      i++;
   }
   return _loc2_;
}
function setTitle(frame)
{
   titles.label.text = ls.titles[frame];
   setStyle(titles.label);
}
function allowStorageChange()
{
   domainSettings.data.klimit = newVal;
   AlertResponse = "klimit";
   usedBox.text = inputState.kcurrent;
   setStyle(usedBox);
   if(inputState.kcurrent != 0)
   {
      gotoAndStop("alert_error");
      t_msg.htmlText = ls.storageError;
      setStyle(t_msg);
      OK.label.text = ls.OK;
      setStyle(OK.label);
   }
   else
   {
      gotoAndStop("_localinformation");
      AlertResponse = "klimit";
      newVal = null;
   }
}
function denyStorageChange()
{
   gotoAndStop("_localInformation");
   newVal = null;
}
function storageErrorOK()
{
   gotoAndStop("_localinformation");
   var _loc1_ = getAppropriateLevel(inputState.kcurrent);
   changeKlimit(_loc1_);
   AlertResponse = "klimit";
}
function changeKlimit(val)
{
   needTwitch = val == -1 && inputState.kcurrent > 0 || val >= 0 && val < inputState.kcurrent;
   if(needTwitch)
   {
      newVal = val;
      gotoAndStop("alert_storage");
      var _loc1_ = 0;
      while(_loc1_ < ls.available.length)
      {
         if(ls.available[_loc1_] == domainSettings.data.klimit)
         {
            myKb = ls.displayAs[_loc1_];
         }
         _loc1_ = _loc1_ + 1;
      }
      sentence = ls.storageAlert;
      var _loc3_ = System.security.escapeDomain(inputState.domain);
      domainStyle = "<font color=\'#0066CC\'>" + _loc3_ + "</font>";
      kbStyle = myKb;
      sentence = Substitute(sentence,"%1",domainStyle);
      sentence = Substitute(sentence,"%2",kbStyle);
      t_msg.htmlText = sentence;
      setStyle(t_msg);
      OK.label.text = ls.OK;
      setStyle(OK.label);
      Cancel.label.text = ls.Cancel;
      setStyle(Cancel.label);
   }
   else
   {
      domainSettings.data.klimit = val;
      AlertResponse = "klimit";
   }
}
function pop_changeKlimit()
{
   domainSettings.data.klimit = newSetting;
   AlertResponse = "ok";
}
function doTab(obj)
{
   myRoot.gotoAndStop("_" + obj);
   iHi.gotoAndStop("i_" + obj);
}
function onChange(btn, a)
{
   if(btn == "Remember")
   {
      domainSettings.data.always = a;
      AlertResponse = "always";
      if(myRoot[btn]._currentframe == 1)
      {
         myRoot[btn].gotoAndStop(2);
      }
      else
      {
         myRoot[btn].gotoAndStop(1);
      }
   }
   else if(btn == "Echo")
   {
      playerSettings.data.echosuppression = a;
      AlertResponse = "echosuppression";
      if(myRoot[btn]._currentframe == 1)
      {
         myRoot[btn].gotoAndStop(2);
      }
      else
      {
         myRoot[btn].gotoAndStop(1);
      }
   }
   else if(btn == "videoSafe")
   {
      playerSettings.data.safefullscreen = a;
      AlertResponse = "safefullscreen";
      if(myRoot[btn]._currentframe == 1)
      {
         myRoot[btn].gotoAndStop(2);
      }
      else
      {
         myRoot[btn].gotoAndStop(1);
      }
   }
}
function setPanel(x)
{
   this.playerSettings.data.panel = x;
}
function goPanel()
{
   var _loc5_ = 3;
   var _loc4_ = 4;
   var _loc6_ = 7;
   pOffset = 3;
   tOffset = 1;
   var _loc2_ = this.playerSettings.data.panel;
   if(_loc2_ == undefined)
   {
      _loc2_ = 4;
   }
   else if(videoSettingsPanelNumber <= _loc2_)
   {
      _loc2_ = _loc2_ - 1;
   }
   var _loc3_ = _loc2_ + pOffset;
   if(inputState.isPrivate && (_loc3_ == _loc5_ || _loc3_ == _loc4_))
   {
      _loc3_ = _loc6_;
      _loc2_ = 4;
   }
   myRoot.gotoAndPlay(_loc3_);
   iHi.gotoAndStop(_loc2_ + tOffset);
}
function frame_dispatch()
{
   goPanel();
}
function frame_privacy()
{
   privacy.gotoAndStop("off");
   localInformation.gotoAndStop("on");
   microphoneSettings.gotoAndStop("on");
   cameraSettings.gotoAndStop("on");
   videoSettings.gotoAndStop("on");
   Allow.label.text = ls.Allow;
   setStyle(Allow.label);
   Deny.label.text = ls.Deny;
   setStyle(Deny.label);
   Remember.msg.text = ls.Remember;
   setStyle(Remember.msg);
   butt_Advanced.label.text = ls.Advanced + "...";
   setStyle(butt_Advanced.label);
   sentence = ls.privacyMsgText;
   var _loc1_ = System.security.escapeDomain(inputState.domain);
   domainStyle = "<font color=\'#0066CC\'>" + _loc1_ + "</font>";
   sentence = Substitute(sentence,"%1",domainStyle);
   t_privacy.htmlText = sentence;
   setStyle(t_privacy);
   setTitle(0);
   setPanel(0);
   cont = "privacy";
   panelName = "privacy";
   stop();
}
function frame_localInformation()
{
   privacy.gotoAndStop("on");
   localInformation.gotoAndStop("off");
   microphoneSettings.gotoAndStop("on");
   cameraSettings.gotoAndStop("on");
   videoSettings.gotoAndStop("on");
   Never.msg.text = ls.Never;
   setStyle(Never.msg);
   sentence = ls.StorageMsgText;
   var _loc1_ = System.security.escapeDomain(inputState.domain);
   domainStyle = "<font color=\'#0066CC\'>" + _loc1_ + "</font>";
   sentence = Substitute(sentence,"%1",domainStyle);
   t_storage.htmlText = sentence;
   setStyle(t_storage);
   Current.text = ls.Current + " " + inputState.kcurrent + kb;
   setStyle(Current);
   cont = "localinfo";
   setTitle(1);
   setPanel(1);
   Close.label.text = ls.Close;
   setStyle(Close.label);
   stop();
}
function checkSlider()
{
   if(domainSettings.data.klimit == -1)
   {
      slider.active = false;
      slider._x = _parent.crib._x;
      slider._alpha = 75;
      crib._alpha = 30;
      Never.gotoAndStop(2);
   }
   else
   {
      slider.active = true;
      Never.gotoAndStop(1);
      slider._alpha = 100;
      crib._alpha = 100;
   }
}
function toggleNever()
{
   Never.hilite.gotoAndStop(1);
   if(slider.active == false)
   {
      slider.active = true;
      Never.gotoAndStop(1);
      slider._alpha = 100;
      crib._alpha = 100;
   }
   else
   {
      slider.active = false;
      Never.gotoAndStop(2);
      changeKlimit(-1);
      localinformationSetting.text = ls.storageLevels[1].label;
      slider._x = crib._x;
      slider._alpha = 75;
      crib._alpha = 30;
   }
}
function frame_microphoneSettings()
{
   privacy.gotoAndStop("on");
   localInformation.gotoAndStop("on");
   microphoneSettings.gotoAndStop("off");
   cameraSettings.gotoAndStop("on");
   videoSettings.gotoAndStop("on");
   Echo.msg.text = ls.Echo;
   setStyle(Echo.msg);
   cont = "microphone";
   setTitle(2);
   setPanel(2);
   micList = Microphone.names;
   Volume.text = ls.Volume;
   setStyle(Volume);
   var _loc2_ = false;
   var _loc1_ = playerSettings.data.defaultMicrophone;
   micmenu.myList = new Array();
   i = 0;
   while(i < micList.length)
   {
      micmenu.myList[i] = micList[i];
      if(_loc1_ == micList[i])
      {
         myDef = _loc1_;
         _loc2_ = true;
      }
      i++;
   }
   if(!_loc2_)
   {
      var _loc3_ = new Object();
      _loc3_.query = "defaultMicrophone";
      myRoot.AlertResponse = _loc3_;
      myDef = _loc3_.response;
   }
   myMic = Microphone["get"]();
   s = new Sound(meter);
   s.setVolume(0);
   meter.attachAudio(myMic);
   Close.label.text = ls.Close;
   setStyle(Close.label);
   stop();
}
function frame_cameraSettings()
{
   privacy.gotoAndStop("on");
   localInformation.gotoAndStop("on");
   microphoneSettings.gotoAndStop("on");
   cameraSettings.gotoAndStop("off");
   videoSettings.gotoAndStop("on");
   cont = "camera";
   camMsg.borderColor = 16777215;
   setTitle(3);
   setPanel(3);
   camMsg.text = ls.waitMsg;
   camList = new Array();
   camList = Camera.names;
   var _loc2_ = false;
   var _loc1_ = playerSettings.data.defaultCamera;
   if(camList.length == 0)
   {
      camMsg._visible = true;
      camMsg.text = ls.noCam;
      setStyle(camMsg);
      camBorder._visible = false;
      return undefined;
   }
   cammenu.myList = new Array();
   i = 0;
   while(i < camList.length)
   {
      cammenu.myList[i] = camList[i];
      if(_loc1_ == camList[i])
      {
         myDef = _loc1_;
         _loc2_ = true;
         camMsg._visible = false;
      }
      i++;
   }
   if(!_loc2_)
   {
      myDef = camList[0];
   }
   foundCams = true;
   camMsg._visible = false;
   myCam = Camera["get"]();
   Close.label.text = ls.Close;
   setStyle(Close.label);
   stop();
}
function frame_videoSettings()
{
   privacy.gotoAndStop("on");
   localInformation.gotoAndStop("on");
   microphoneSettings.gotoAndStop("on");
   cameraSettings.gotoAndStop("on");
   videoSettings.gotoAndStop("off");
   cont = "video";
   panelName = "video";
   setTitle(7);
   setPanel(4);
   videoSafe.msg.text = ls.videoSafe;
   setStyle(videoSafe.msg);
   Close.label.text = ls.Close;
   setStyle(Close.label);
   stop();
}
function showVid()
{
   myView.attachVideo(myCam);
   camBorder_butt.vidCover._visible = false;
}
function frame_pop_storage()
{
   s = 0;
   while(s < ls.available.length)
   {
      if(ls.available[s] == -2)
      {
         break;
      }
      if(inputState.krequest <= ls.available[s])
      {
         break;
      }
      s++;
   }
   setTitle(1);
   Allow.label.text = ls.Allow;
   setStyle(Allow.label);
   Deny.label.text = ls.Deny;
   setStyle(Deny.label);
   newSetting = ls.available[s];
   sentence = ls.popUp_StorageText;
   sentence2 = ls.popUp_StorageData;
   var _loc1_ = System.security.escapeDomain(inputState.domain);
   domainStyle = "<font color=\'#0066CC\'>" + _loc1_ + "</font>";
   kbStyle = ls.displayAs[s];
   currentKvalue = inputState.kcurrent + " " + kb;
   sentence = Substitute(sentence,"%1",domainStyle);
   sentence2 = Substitute(sentence2,"%2",kbStyle);
   sentence2 = Substitute(sentence2,"%3",currentKvalue);
   t_msg.htmlText = sentence;
   setStyle(t_msg);
   t_storageData.htmlText = sentence2;
   setStyle(t_storageData);
   cont = "pop_localinfo";
}
function frame_pop_privacy()
{
   setTitle(6);
   Allow.label.text = ls.Allow;
   setStyle(Allow.label);
   Deny.label.text = ls.Deny;
   setStyle(Deny.label);
   sentence = ls.PrivacyPopMsgText;
   var _loc1_ = System.security.escapeDomain(inputState.domain);
   domainStyle = "<font color=\'#0066CC\'>" + _loc1_ + "</font>";
   sentence = Substitute(sentence,"%1",domainStyle);
   pop_priv_msg.htmlText = sentence;
   setStyle(pop_priv_msg);
   cont = "pop_privacy";
}
function frame_pop_screenshare()
{
   setTitle(4);
   Allow.label.text = ls.Allow;
   setStyle(Allow.label);
   Deny.label.text = ls.Deny;
   setStyle(Deny.label);
   sentence = ls.ScreenPrivacyMsgText;
   var _loc2_ = System.security.escapeDomain(inputState.domain);
   domainStyle = "<font color=\'#0066CC\'>" + _loc2_ + "</font>";
   sentence = Substitute(sentence,"%1",domainStyle);
   pop_screenshare_msg.htmlText = sentence;
   setStyle(pop_screenshare_msg);
   winmenu.myList = new Array();
   var _loc1_ = 0;
   while(_loc1_ < inputState.windowList.length)
   {
      winmenu.myList[_loc1_] = inputState.windowList[_loc1_];
      _loc1_ += 1;
   }
   myDef = winmenu.myList[0];
   cont = "pop_screenshare";
}
function frame_pop_crossdomain()
{
   setTitle(5);
   securityRemember.msg.text = ls.securityRemember;
   setStyle(securityRemember.msg);
   Allow.label.text = ls.Allow;
   setStyle(Allow.label);
   Deny.label.text = ls.Deny;
   setStyle(Deny.label);
   var _loc4_ = System.security.escapeDomain(inputState.accessorDomain);
   var _loc3_ = System.security.escapeDomain(inputState.providerDomain);
   var _loc5_ = "<font color=\'#0066CC\'>" + _loc4_ + "</font>";
   var _loc2_ = "<font color=\'#0066CC\'>" + _loc3_ + "</font>";
   var _loc1_ = Substitute(ls.securityMsg,"%1",_loc5_);
   _loc1_ = Substitute(_loc1_,"%2",_loc2_);
   pop_crossdomain_msg.htmlText = _loc1_;
   setStyle(pop_crossdomain_msg);
   if(myStyle == "altStyle")
   {
      titles.label._y -= 1;
      pop_crossdomain_msg._y -= 2;
   }
   cont = "pop_crossdomain";
}
function frame_pop_p2p()
{
   setTitle(8);
   Allow.label.text = ls.Allow;
   setStyle(Allow.label);
   Deny.label.text = ls.Deny;
   setStyle(Deny.label);
   butt_Advanced.label.text = ls.Advanced + "...";
   setStyle(butt_Advanced.label);
   if(inputState.isPrivate)
   {
      securityRemember._visible = false;
   }
   else
   {
      securityRemember.msg.text = ls.Remember;
      setStyle(Remember.msg);
   }
   var _loc1_ = ls.P2PPrivacyMsgText;
   var _loc2_ = System.security.escapeDomain(inputState.domain);
   domainStyle = "<font color=\'#0066CC\'>" + _loc2_ + "</font>";
   _loc1_ = Substitute(_loc1_,"%1",domainStyle);
   pop_p2p_msg.htmlText = _loc1_;
   cont = "pop_p2p";
}
function Substitute(input, token, value)
{
   var _loc1_ = input.indexOf(token);
   if(_loc1_ < 0)
   {
      return input;
   }
   var _loc2_ = value + input.substr(_loc1_ + 2);
   if(_loc1_ > 0)
   {
      _loc2_ = input.substr(0,_loc1_) + _loc2_;
   }
   return _loc2_;
}
function getHelpURL()
{
   ASNative(2107,99)(cont,System.capabilities.language);
}
function visibleCheck(p)
{
   if(String(p._root) == "")
   {
      clearInterval(p.intid);
   }
   var _loc2_ = p._root.CheckVisibility(210,130);
   if(_loc2_ === false)
   {
      p.visibleCount = 0;
   }
   else
   {
      p.visibleCount = p.visibleCount + 1;
   }
}
function frame_DP_init()
{
   windowTitle.text = ls.installerTitle;
   setStyle(windowTitle);
   checkPort(windowTitle);
   DP_msg.text = ls.installerConnecting;
   setStyle(DP_msg);
   busy_mc._visible = false;
   visInterval = setInterval(this.busyVisible,1000);
   this.translation = new XML();
   translation.ignoreWhite = true;
   translation.owner = this;
   translation.onLoad = function(success)
   {
      if(visInterval != null)
      {
         clearInterval(visInterval);
         visInterval = true;
      }
      if(success && this.status == 0)
      {
         success = this.owner.extractStringsFromXML();
      }
      delete this.owner.translation;
      if(success && this.status == 0)
      {
         this.owner.gotoAndStop("DP_dialog");
      }
      else
      {
         this.owner.errorCode = 2;
         this.owner.gotoAndStop("DP_error");
      }
   };
   if(inputState.useCGI)
   {
      translation.load(inputState.url + "&what=descr");
   }
   else
   {
      translation.load(inputState.url);
   }
   this._x = xOffset;
   this._y = yOffset;
   killHand();
   stop();
   Cancel.label.text = ls.Cancel;
   setStyle(Cancel.label);
   ec = new Array();
   ec[0] = ls.DP_error_0;
   ec[1] = ls.DP_error_1;
   ec[2] = ls.DP_error_2;
   ec[3] = ls.DP_error_3;
   ec[4] = ls.DP_error_4;
   this.errorCode = 0;
}
function busyVisible()
{
   busy_mc._visible = true;
   clearInterval(visInterval);
   visInterval = null;
}
function extractStringsFromXML()
{
   if(translation.firstChild.nodeName != "FlashDownloadStrings")
   {
      return false;
   }
   var _loc4_ = null;
   var _loc5_ = translation.firstChild;
   if(inputState.param != undefined && inputState.param.length > 0)
   {
      var _loc1_ = translation.firstChild;
      while(_loc1_ !== null)
      {
         if(_loc1_.nodeName == "FlashDownloadStrings")
         {
            if(_loc1_.attributes.param == inputState.param)
            {
               _loc4_ = _loc1_;
               break;
            }
            if(_loc1_.attributes.param == "default" || _loc1_.attributes.param == undefined)
            {
               _loc5_ = _loc1_;
            }
         }
         _loc1_ = _loc1_.nextSibling;
      }
   }
   if(_loc4_ == null)
   {
      _loc4_ = _loc5_;
   }
   var _loc3_ = null;
   var _loc6_ = null;
   var _loc7_ = System.capabilities.language;
   _loc1_ = _loc4_.firstChild;
   while(_loc1_ !== null)
   {
      if(_loc1_.nodeName == "translation")
      {
         if(_loc1_.attributes.lang == _loc7_)
         {
            _loc3_ = _loc1_;
            break;
         }
         if(_loc1_.attributes.lang == "en-US")
         {
            _loc6_ = _loc1_;
         }
      }
      _loc1_ = _loc1_.nextSibling;
   }
   if(_loc3_ === null)
   {
      _loc3_ = _loc6_;
   }
   if(_loc3_ === null)
   {
      return false;
   }
   _loc1_ = _loc3_.firstChild;
   while(_loc1_ !== null)
   {
      if(_loc1_.nodeName == "string")
      {
         var _loc2_ = _loc1_.attributes.id;
         txt = _loc1_.firstChild.nodeValue;
         ls[_loc2_] = txt;
      }
      _loc1_ = _loc1_.nextSibling;
   }
   return true;
}
function frame_DP_dialog()
{
   windowTitle.text = ls.installerTitle;
   setStyle(windowTitle);
   checkPort(windowTitle);
   killHand();
   stop();
   var _loc1_ = new Object();
   _loc1_.start = true;
   AlertResponse = _loc1_;
   sentence = ls.installMsg_confirm;
   DP_msg.htmlText = sentence;
   setStyle(DP_msg);
   Yes.label.text = ls.Yes;
   setStyle(Yes.label);
   No.label.text = ls.No;
   setStyle(No.label);
}
function download()
{
   var _loc2_ = new Object();
   AlertResponse = _loc2_;
   if(_loc2_.length == -1)
   {
      _root.errorCode = 2;
      gotoAndStop("DP_error");
      clearInterval(checkIt);
   }
   else if(_loc2_.length != 0)
   {
      progBar.bar._width = _loc2_.position / _loc2_.length * progBar.rect._width;
      if(_loc2_.position == _loc2_.length)
      {
         clearInterval(checkIt);
         _loc2_.finish = true;
         AlertResponse = _loc2_;
         if(_loc2_.error)
         {
            _root.errorCode = _loc2_.error != 3 ? 2 : 3;
            gotoAndStop("DP_error");
         }
         else
         {
            AlertResponse = 0;
         }
      }
   }
   stop();
}
function frame_DP_download()
{
   windowTitle.text = ls.installerTitle;
   setStyle(windowTitle);
   checkPort(windowTitle);
   Cancel.label.text = ls.Cancel;
   setStyle(Cancel.label);
   DP_msg.htmlText = ls.installMsg_progress;
   setStyle(DP_msg);
   stop();
}
function frame_DP_error()
{
   windowTitle.text = ls.installerTitle;
   setStyle(windowTitle);
   checkPort(windowTitle);
   Retry.label.text = ls.Retry;
   setStyle(Retry.label);
   Cancel.label.text = ls.Cancel;
   setStyle(Cancel.label);
   DP_msg.htmlText = ec[this.errorCode];
   setStyle(DP_msg);
   stop();
}
function DP_dl_accept()
{
   userAccepted = true;
   checkIt = setInterval(this.download,200,this);
   gotoAndStop("DP_download");
}
function DP_dl_retry()
{
   if(userAccepted)
   {
      checkIt = setInterval(this.download,200,this);
      gotoAndStop("DP_download");
   }
   else
   {
      gotoAndStop("DP_init");
   }
}
function DP_dl_deny()
{
   AlertResponse = 1;
}
stop();
if(inputState.domain == null)
{
   inputState = new Object();
   inputState.domain = "somesiteintheworld.com";
}
if(inputState.isAOL)
{
   inputState.domain = "AOL";
   windowTitle._visible = false;
   settings_helper._visible = false;
   localinformation._visible = false;
   var spacing = microphoneSettings._x - localinformation._x;
   microphoneSettings._x = localinformation._x;
   cameraSettings._x = microphoneSettings._x + spacing;
}
videoSettingsPanelNumber = 5;
myRoot = this;
domainSettings = SharedObject.getLocal(inputState.domain + "/settings",inputState.scope);
playerSettings = SharedObject.getLocal("settings",inputState.scope);
movInit();
checkMode();
myMenuInit = function(menuObj)
{
   stop();
   menuObj.menu = false;
   menuObj.onSel = false;
   menuObj.selected = myDef;
   menuObj.sel.title.text = menuObj.selected;
   menuObj.displayAs = new Array();
};
drawMenu = function(p)
{
   activeMenu = p;
   p.menu = true;
   i = 0;
   while(i < p.mylist.length)
   {
      p.displayAs[i] = p.myList[i];
      p.attachMovie("item",i,i);
      p[i]._y = p.sel._height + p.sel._height * i;
      p[i]._x = 0;
      p[i].title.text = p.displayAs[i];
      i++;
   }
   p.lastClip = p.myList.length - 1;
};
killClips = function(o)
{
   i = 0;
   while(i < o.myList.length)
   {
      removeMovieClip(o[i]);
      i++;
   }
   o.menu = false;
   activeMenu = null;
};
showSel = function(obj, parent)
{
   parent.sel.title.text = parent.displayAs[obj._name];
   setSo(parent.displayAs[obj._name],parent);
   killClips(parent);
};
setSo = function(val, parent)
{
   if(parent._name == "cammenu")
   {
      myRoot.playerSettings.data.defaultCamera = val;
      myRoot.AlertResponse = "defaultCamera";
      myview.Clear();
   }
   else if(parent._name == "micmenu")
   {
      myRoot.playerSettings.data.defaultMicrophone = val;
      myRoot.AlertResponse = "defaultMicrophone";
   }
};
arrowAction = function(obj)
{
   if(!obj._parent.menu)
   {
      drawMenu(obj._parent);
   }
   else
   {
      killClips(obj._parent);
   }
};
outsideMenu = function(obj, par)
{
   var _loc3_ = new Object();
   _loc3_.x = obj._xmouse;
   _loc3_.y = obj._ymouse;
   obj.localToGlobal(_loc3_);
   if(!obj.hitTest(_loc3_.x,_loc3_.y,false) && par.onSel == false && activeMenu != null)
   {
      var _loc1_ = 0;
      while(_loc1_ < par.myList.length)
      {
         removeMovieClip(par[_loc1_]);
         _loc1_ = _loc1_ + 1;
      }
      activeMenu = null;
      par.menu = false;
   }
};
myobj = new Object();
myobj.visibleCount = 0;
myobj.intid = setInterval(visibleCheck,100,myobj);
myobj._root = _root;
_root.doVisibilityCheck = function()
{
   if(myobj.visibleCount < 10)
   {
      return false;
   }
   var _loc2_ = _root.CheckVisibility(210,130);
   if(_loc2_ === false)
   {
      return false;
   }
   return true;
};
checkIt = null;
userAccepted = false;
killHand();
