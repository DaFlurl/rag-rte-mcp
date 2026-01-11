package com.evony.useful {
    import flash.filesystem.File;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;
    import flash.events.Event;
    import flash.events.ErrorEvent;
    import flash.utils.Dictionary;
    import flash.events.EventDispatcher;
    
    public class ScriptManager extends EventDispatcher {
        private static var _instance:ScriptManager;
        private var _scriptsDir:File;
        private var _backupsDir:File;
        private var _templatesDir:File;
        private var _scripts:Dictionary;
        
        // Base paths
        private static const BASE_PATH:String = "c:/evony/Useful/scripts";
        private static const BACKUPS_PATH:String = BASE_PATH + "/backups";
        private static const TEMPLATES_PATH:String = BASE_PATH + "/templates";
        
        public function ScriptManager() {
            if (_instance) {
                throw new Error("Singleton - use getInstance()");
            }
            initialize();
        }
        
        public static function getInstance():ScriptManager {
            if (!_instance) {
                _instance = new ScriptManager();
            }
            return _instance;
        }
        
        private function initialize():void {
            _scripts = new Dictionary();
            setupDirectories();
            loadExistingScripts();
        }
        
        private function setupDirectories():void {
            // Create main scripts directory
            _scriptsDir = new File(BASE_PATH);
            if (!_scriptsDir.exists) {
                _scriptsDir.createDirectory();
            }
            
            // Create backups directory
            _backupsDir = new File(BACKUPS_PATH);
            if (!_backupsDir.exists) {
                _backupsDir.createDirectory();
            }
            
            // Create templates directory
            _templatesDir = new File(TEMPLATES_PATH);
            if (!_templatesDir.exists) {
                _templatesDir.createDirectory();
            }
        }
        
        /**
         * Load all existing scripts
         */
        private function loadExistingScripts():void {
            var files:Array = _scriptsDir.getDirectoryListing();
            for each (var file:File in files) {
                if (file.extension == "as") {
                    loadScript(file);
                }
            }
        }
        
        /**
         * Create a new script
         */
        public function createScript(
            name:String,
            content:String,
            type:String = "general"
        ):Object {
            var timestamp:String = new Date().time.toString();
            var filename:String = name.replace(/\s+/g, "_") + ".as";
            var file:File = _scriptsDir.resolvePath(filename);
            
            // Create script metadata
            var metadata:Object = {
                name: name,
                type: type,
                created: timestamp,
                modified: timestamp,
                backups: []
            };
            
            // Save the script
            saveFile(file, content);
            saveMetadata(file, metadata);
            
            _scripts[filename] = metadata;
            return metadata;
        }
        
        /**
         * Edit an existing script
         */
        public function editScript(
            filename:String,
            newContent:String
        ):Object {
            var file:File = _scriptsDir.resolvePath(filename);
            if (!file.exists) {
                throw new Error("Script not found: " + filename);
            }
            
            // Create backup before editing
            createBackup(filename);
            
            // Update the script
            saveFile(file, newContent);
            
            // Update metadata
            var metadata:Object = _scripts[filename];
            metadata.modified = new Date().time.toString();
            saveMetadata(file, metadata);
            
            return metadata;
        }
        
        /**
         * Create a backup of a script
         */
        private function createBackup(filename:String):void {
            var sourceFile:File = _scriptsDir.resolvePath(filename);
            var timestamp:String = new Date().time.toString();
            var backupName:String = filename.replace(".as", "") + 
                                  "_" + timestamp + ".as";
            var backupFile:File = _backupsDir.resolvePath(backupName);
            
            // Copy the file
            sourceFile.copyTo(backupFile);
            
            // Update metadata
            var metadata:Object = _scripts[filename];
            metadata.backups.push({
                filename: backupName,
                timestamp: timestamp
            });
            saveMetadata(sourceFile, metadata);
        }
        
        /**
         * Save file content
         */
        private function saveFile(file:File, content:String):void {
            var stream:FileStream = new FileStream();
            stream.open(file, FileMode.WRITE);
            stream.writeUTFBytes(content);
            stream.close();
        }
        
        /**
         * Save metadata for a script
         */
        private function saveMetadata(scriptFile:File, metadata:Object):void {
            var metaFile:File = _scriptsDir.resolvePath(
                scriptFile.name + ".meta"
            );
            saveFile(metaFile, JSON.stringify(metadata, null, 2));
        }
        
        /**
         * Load a script's content and metadata
         */
        private function loadScript(file:File):void {
            var metaFile:File = _scriptsDir.resolvePath(file.name + ".meta");
            if (metaFile.exists) {
                var stream:FileStream = new FileStream();
                stream.open(metaFile, FileMode.READ);
                var metadata:Object = JSON.parse(stream.readUTFBytes(
                    stream.bytesAvailable
                ));
                stream.close();
                
                _scripts[file.name] = metadata;
            }
        }
        
        /**
         * Get all scripts
         */
        public function getScripts():Array {
            var scripts:Array = [];
            for (var filename:String in _scripts) {
                scripts.push({
                    filename: filename,
                    metadata: _scripts[filename]
                });
            }
            return scripts;
        }
        
        /**
         * Get script content
         */
        public function getScriptContent(filename:String):String {
            var file:File = _scriptsDir.resolvePath(filename);
            if (!file.exists) {
                throw new Error("Script not found: " + filename);
            }
            
            var stream:FileStream = new FileStream();
            stream.open(file, FileMode.READ);
            var content:String = stream.readUTFBytes(stream.bytesAvailable);
            stream.close();
            
            return content;
        }
        
        /**
         * Get script backups
         */
        public function getScriptBackups(filename:String):Array {
            var metadata:Object = _scripts[filename];
            return metadata ? metadata.backups : [];
        }
        
        /**
         * Restore from backup
         */
        public function restoreFromBackup(
            filename:String,
            backupTimestamp:String
        ):void {
            var metadata:Object = _scripts[filename];
            if (!metadata) {
                throw new Error("Script not found: " + filename);
            }
            
            var backup:Object = metadata.backups.find(function(b:Object):Boolean {
                return b.timestamp == backupTimestamp;
            });
            
            if (!backup) {
                throw new Error("Backup not found");
            }
            
            var backupFile:File = _backupsDir.resolvePath(backup.filename);
            var targetFile:File = _scriptsDir.resolvePath(filename);
            
            // Create a new backup of current version
            createBackup(filename);
            
            // Restore from backup
            backupFile.copyTo(targetFile, true);
            
            // Update metadata
            metadata.modified = new Date().time.toString();
            metadata.restoredFrom = backupTimestamp;
            saveMetadata(targetFile, metadata);
        }
    }
}
