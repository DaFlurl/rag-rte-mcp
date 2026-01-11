package com.evony.useful {
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import flash.net.SharedObject;
    
    public class TemplateSyncManager extends EventDispatcher {
        private static var _instance:TemplateSyncManager;
        private var _syncStorage:SharedObject;
        private var _sharedTemplates:Object = {};
        private var _syncQueue:Array = [];
        private var _activeSync:Boolean = false;
        
        // Sharing modes
        private static const SHARE_MODES:Object = {
            PRIVATE: "private",    // Only owner can access
            READONLY: "readonly",  // Others can view but not modify
            COLLABORATIVE: "collaborative"  // Full access for all
        };
        
        // Sync states
        private static const SYNC_STATES:Object = {
            PENDING: "pending",
            SYNCING: "syncing",
            COMPLETED: "completed",
            FAILED: "failed",
            CONFLICT: "conflict"
        };
        
        public function TemplateSyncManager() {
            if (_instance) {
                throw new Error("Singleton - use getInstance()");
            }
            initialize();
        }
        
        public static function getInstance():TemplateSyncManager {
            if (!_instance) {
                _instance = new TemplateSyncManager();
            }
            return _instance;
        }
        
        /**
         * Share template
         */
        public function shareTemplate(
            template:Object,
            mode:String = "readonly",
            recipients:Array = null
        ):Object {
            var result:Object = {
                success: false,
                shareId: "",
                errors: []
            };
            
            try {
                // Generate share ID
                var shareId:String = generateShareId();
                
                // Create shared template
                var shared:Object = {
                    id: shareId,
                    template: template,
                    mode: mode,
                    owner: getCurrentUser(),
                    recipients: recipients || [],
                    created: new Date().time,
                    modified: new Date().time,
                    version: template.version,
                    status: "active",
                    metadata: generateShareMetadata(template)
                };
                
                // Store shared template
                _sharedTemplates[shareId] = shared;
                
                // Queue for sync
                queueForSync({
                    type: "share",
                    data: shared
                });
                
                result.success = true;
                result.shareId = shareId;
                
            } catch (e:Error) {
                result.errors.push(e.message);
            }
            
            return result;
        }
        
        /**
         * Access shared template
         */
        public function accessSharedTemplate(shareId:String):Object {
            var result:Object = {
                success: false,
                template: null,
                errors: []
            };
            
            try {
                var shared:Object = _sharedTemplates[shareId];
                if (!shared) {
                    throw new Error("Shared template not found");
                }
                
                // Check access permissions
                if (!hasAccess(shared)) {
                    throw new Error("Access denied");
                }
                
                result.success = true;
                result.template = shared.template;
                
            } catch (e:Error) {
                result.errors.push(e.message);
            }
            
            return result;
        }
        
        /**
         * Update shared template
         */
        public function updateSharedTemplate(
            shareId:String,
            updates:Object
        ):Object {
            var result:Object = {
                success: false,
                errors: []
            };
            
            try {
                var shared:Object = _sharedTemplates[shareId];
                if (!shared) {
                    throw new Error("Shared template not found");
                }
                
                // Check write permissions
                if (!hasWriteAccess(shared)) {
                    throw new Error("Write access denied");
                }
                
                // Apply updates
                for (var field:String in updates) {
                    if (field != "id" && field != "owner") {
                        shared.template[field] = updates[field];
                    }
                }
                
                // Update metadata
                shared.modified = new Date().time;
                shared.version = shared.template.version;
                shared.metadata = generateShareMetadata(shared.template);
                
                // Queue for sync
                queueForSync({
                    type: "update",
                    data: shared
                });
                
                result.success = true;
                
            } catch (e:Error) {
                result.errors.push(e.message);
            }
            
            return result;
        }
        
        /**
         * Revoke sharing
         */
        public function revokeSharing(shareId:String):Object {
            var result:Object = {
                success: false,
                errors: []
            };
            
            try {
                var shared:Object = _sharedTemplates[shareId];
                if (!shared) {
                    throw new Error("Shared template not found");
                }
                
                // Check ownership
                if (shared.owner != getCurrentUser()) {
                    throw new Error("Only owner can revoke sharing");
                }
                
                // Mark as revoked
                shared.status = "revoked";
                shared.modified = new Date().time;
                
                // Queue for sync
                queueForSync({
                    type: "revoke",
                    data: shared
                });
                
                result.success = true;
                
            } catch (e:Error) {
                result.errors.push(e.message);
            }
            
            return result;
        }
        
        /**
         * Start sync process
         */
        public function startSync():void {
            if (_activeSync) return;
            
            _activeSync = true;
            processQueue();
        }
        
        /**
         * Stop sync process
         */
        public function stopSync():void {
            _activeSync = false;
        }
        
        /**
         * Get sync status
         */
        public function getSyncStatus():Object {
            return {
                active: _activeSync,
                queueLength: _syncQueue.length,
                lastSync: getLastSyncTime()
            };
        }
        
        // Helper functions
        private function initialize():void {
            initializeStorage();
            loadSharedTemplates();
        }
        
        private function initializeStorage():void {
            try {
                _syncStorage = SharedObject.getLocal("templateSync");
            } catch (e:Error) {
                trace("Error initializing sync storage: " + e.message);
            }
        }
        
        private function loadSharedTemplates():void {
            try {
                if (_syncStorage && _syncStorage.data.shared) {
                    _sharedTemplates = _syncStorage.data.shared;
                }
            } catch (e:Error) {
                trace("Error loading shared templates: " + e.message);
            }
        }
        
        private function generateShareId():String {
            return "share_" + new Date().time + "_" + 
                   Math.floor(Math.random() * 1000);
        }
        
        private function generateShareMetadata(template:Object):Object {
            return {
                size: JSON.stringify(template).length,
                hash: generateContentHash(template),
                lastSync: new Date().time
            };
        }
        
        private function hasAccess(shared:Object):Boolean {
            var user:String = getCurrentUser();
            
            // Owner always has access
            if (shared.owner == user) return true;
            
            // Check recipient list
            if (shared.recipients && shared.recipients.indexOf(user) != -1) {
                return true;
            }
            
            return false;
        }
        
        private function hasWriteAccess(shared:Object):Boolean {
            if (!hasAccess(shared)) return false;
            
            var user:String = getCurrentUser();
            
            // Owner always has write access
            if (shared.owner == user) return true;
            
            // Check share mode
            return shared.mode == SHARE_MODES.COLLABORATIVE;
        }
        
        private function queueForSync(item:Object):void {
            item.queued = new Date().time;
            item.state = SYNC_STATES.PENDING;
            _syncQueue.push(item);
            
            if (_activeSync) {
                processQueue();
            }
        }
        
        private function processQueue():void {
            if (!_activeSync || _syncQueue.length == 0) return;
            
            var item:Object = _syncQueue[0];
            item.state = SYNC_STATES.SYNCING;
            
            try {
                switch (item.type) {
                    case "share":
                        syncShare(item);
                        break;
                    case "update":
                        syncUpdate(item);
                        break;
                    case "revoke":
                        syncRevoke(item);
                        break;
                }
                
                item.state = SYNC_STATES.COMPLETED;
                _syncQueue.shift();
                
                // Process next item
                processQueue();
                
            } catch (e:Error) {
                item.state = SYNC_STATES.FAILED;
                item.error = e.message;
                
                // Retry later
                setTimeout(processQueue, 5000);
            }
        }
        
        private function syncShare(item:Object):void {
            // Sync share operation
            saveToStorage();
        }
        
        private function syncUpdate(item:Object):void {
            // Sync update operation
            saveToStorage();
        }
        
        private function syncRevoke(item:Object):void {
            // Sync revoke operation
            saveToStorage();
        }
        
        private function saveToStorage():void {
            try {
                if (_syncStorage) {
                    _syncStorage.data.shared = _sharedTemplates;
                    _syncStorage.flush();
                }
            } catch (e:Error) {
                trace("Error saving to storage: " + e.message);
            }
        }
        
        private function getCurrentUser():String {
            // Get current user info
            return "user";
        }
        
        private function generateContentHash(content:Object):String {
            // Generate hash of content
            return "hash";
        }
        
        private function getLastSyncTime():Number {
            // Get last successful sync time
            return 0;
        }
    }
}
