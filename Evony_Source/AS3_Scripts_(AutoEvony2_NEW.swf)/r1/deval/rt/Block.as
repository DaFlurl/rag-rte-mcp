// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//r1.deval.rt.Block

package r1.deval.rt
{
    import r1.deval.parser.BaseParser;

    public class Block 
    {

        private static var blockCount:int = 0;

        private var _trueNext:Block;
        private var _cond:IExpr;
        private var _falseReferencers:Array = null;
        public var name:String;
        private var _trueReferencers:Array = null;
        private var _optimized:Boolean = false;
        public var stmts:Array;
        private var _cond_lineno:int;
        private var _falseNext:Block;
        private var _lastIsExit:Boolean = false;

        public function Block(_arg_1:String=null, _arg_2:Boolean=true)
        {
            if (((BaseParser.debugDump) || (!(_arg_2))))
            {
                if (_arg_2)
                {
                    if (_arg_1 == null)
                    {
                        _arg_1 = "";
                    };
                    this.name = ((_arg_1 + "/") + ++blockCount);
                }
                else
                {
                    this.name = _arg_1;
                };
            };
            _optimized = (!(_arg_2));
        }

        public function isSimple():Boolean
        {
            return (_cond == null);
        }

        public function info(_arg_1:int=0):String
        {
            var _local_6:IStmt;
            var _local_2:* = "";
            var _local_3:int;
            while (_local_3 < _arg_1)
            {
                _local_2 = (_local_2 + "  ");
                _local_3++;
            };
            var _local_4:String = ("\n" + _local_2);
            if ((this is EndBlock))
            {
                if (this == EndBlock.EXIT)
                {
                    return (((_local_2 + '<EXIT name="') + name) + '" />');
                };
                return (null);
            };
            if (isConditional())
            {
                return (_local_2 + condInfo(true));
            };
            var _local_5:* = (((((_local_2 + '<Block name="') + name) + '" optimized="') + _optimized) + '">');
            for each (_local_6 in stmts)
            {
                _local_5 = (_local_5 + (_local_4 + "  <stmt"));
                if (_local_6.lineno > 0)
                {
                    _local_5 = (_local_5 + ((' line="' + _local_6.lineno) + '"'));
                };
                _local_5 = (_local_5 + ((">" + String(_local_6)) + "</stmt>"));
            };
            return (((((_local_5 + _local_4) + "  ") + condInfo()) + _local_4) + "</Block>");
        }

        public function addStmt(_arg_1:Object, _arg_2:int=0):void
        {
            if (stmts == null)
            {
                stmts = [];
            };
            if (!(_arg_1 is IStmt))
            {
                if ((_arg_1 is IExpr))
                {
                    _arg_1 = new ExprStmt((_arg_1 as IExpr), _arg_2);
                };
            };
            stmts.push(_arg_1);
        }

        public function isEmpty():Boolean
        {
            return (((isSimple()) && ((stmts == null) || (stmts.length == 0))) && (!(this is EndBlock)));
        }

        private function addReferencer(_arg_1:Block, _arg_2:Boolean=true):void
        {
            if (_arg_2)
            {
                if (_trueReferencers == null)
                {
                    _trueReferencers = [];
                };
                _trueReferencers.push(_arg_1);
            }
            else
            {
                if (_falseReferencers == null)
                {
                    _falseReferencers = [];
                };
                _falseReferencers.push(_arg_1);
            };
        }

        public function set trueNext(_arg_1:Block):void
        {
            if (_trueNext != null)
            {
                _trueNext.removeReferencer(this);
            };
            _trueNext = _arg_1;
            if (_arg_1 != null)
            {
                _arg_1.addReferencer(this);
            };
        }

        public function isConditional():Boolean
        {
            return (((stmts == null) || (stmts.length == 0)) && (!(_cond == null)));
        }

        public function getCond():IExpr
        {
            return (_cond);
        }

        public function run(_arg_1:Block=null):void
        {
            if (_arg_1 == null)
            {
                _arg_1 = EndBlock.EXIT;
            };
            var _local_2:Block = this;
            var _local_3:Number = 0;
            while (((!(_local_2 == null)) && (!(_local_2 == _arg_1))))
            {
                _local_2 = _local_2.exec();
                if (_local_3 > Env.INFINITE_LOOP_LIMIT)
                {
                    throw (new RTError("msg.rt.infinite.loop"));
                };
                _local_3++;
            };
        }

        public function get lastIsExit():Boolean
        {
            return ((_lastIsExit) || (_trueNext is EndBlock));
        }

        public function exec():Block
        {
            var s:IStmt;
            if (stmts != null)
            {
                for each (s in stmts)
                {
                    try
                    {
                        s.exec();
                    }
                    catch(e:Error)
                    {
                        if ((e is RTError))
                        {
                            (e as RTError).lineno = s.lineno;
                        };
                        throw (e);
                    };
                };
            };
            if (((_cond == null) || (_cond.getBoolean())))
            {
                return (_trueNext);
            };
            return (_falseNext);
        }

        public function get trueNext():Block
        {
            return (_trueNext);
        }

        public function setCond(_arg_1:IExpr, _arg_2:int=-1):void
        {
            _cond = _arg_1;
            if (_arg_2 >= 0)
            {
                _cond_lineno = _arg_2;
            };
        }

        public function set falseNext(_arg_1:Block):void
        {
            if (_falseNext != null)
            {
                _falseNext.removeReferencer(this, false);
            };
            _falseNext = _arg_1;
            if (_arg_1 != null)
            {
                _arg_1.addReferencer(this, false);
            };
        }

        public function condInfo(_arg_1:Boolean=false):String
        {
            if ((trueNext is EndBlock))
            {
                return ("<return/>");
            };
            var _local_2:String = ((_cond == null) ? "<goto " : "<test ");
            if (((_arg_1) && (!(name == null))))
            {
                _local_2 = (_local_2 + (('name="' + name) + '" '));
            };
            if (_cond != null)
            {
                _local_2 = (_local_2 + (('expr="' + String(_cond)) + '" '));
            };
            if (_cond_lineno > 0)
            {
                _local_2 = (_local_2 + (('line="' + _cond_lineno) + '" '));
            };
            if (_trueNext != null)
            {
                _local_2 = (_local_2 + (('trueNext="' + _trueNext.name) + '" '));
            };
            if (((!(_falseNext == null)) && (!(_cond == null))))
            {
                _local_2 = (_local_2 + (('falseNext="' + _falseNext.name) + '" '));
            };
            return (_local_2 + "/>");
        }

        private function removeReferencer(_arg_1:Block, _arg_2:Boolean=true):void
        {
            if (_arg_2)
            {
                if (_trueReferencers != null)
                {
                    _trueReferencers.splice(_trueReferencers.indexOf(this));
                };
            }
            else
            {
                if (_falseReferencers != null)
                {
                    _falseReferencers.splice(_falseReferencers.indexOf(this));
                };
            };
        }

        public function dump(_arg_1:Object, _arg_2:int=0):void
        {
            if (_arg_1[name] != null)
            {
                return;
            };
            _arg_1[name] = true;
            var _local_3:String = info(_arg_2);
            if (_local_3 != null)
            {
                trace(("\n" + _local_3));
            };
            if (trueNext != null)
            {
                trueNext.dump(_arg_1, _arg_2);
            };
            if (falseNext != null)
            {
                falseNext.dump(_arg_1, _arg_2);
            };
        }

        public function optimize():void
        {
            var _local_1:Block;
            var _local_2:Object;
            var _local_3:Block;
            if (_optimized)
            {
                return;
            };
            _optimized = true;
            if (((!(_trueNext == null)) && (!(_trueNext is EndBlock))))
            {
                _trueNext.optimize();
                if (_trueNext.isEmpty())
                {
                    trueNext = _trueNext.trueNext;
                }
                else
                {
                    if (isSimple())
                    {
                        _local_1 = (_trueNext as Block);
                        if (((_local_1.getRefCount() == 1) && (_local_1.isSimple())))
                        {
                            if (stmts == null)
                            {
                                stmts = _local_1.stmts;
                            }
                            else
                            {
                                for each (_local_2 in _local_1.stmts)
                                {
                                    stmts.push(_local_2);
                                };
                            };
                            trueNext = _local_1.trueNext;
                        };
                    };
                };
            };
            if (((!(_falseNext == null)) && (!(_falseNext is EndBlock))))
            {
                _falseNext.optimize();
                if (_falseNext.isEmpty())
                {
                    falseNext = _falseNext.trueNext;
                };
            };
            if (isEmpty())
            {
                for each (_local_3 in _trueReferencers)
                {
                    if (_local_3 != null)
                    {
                        _local_3._trueNext = _trueNext;
                    };
                };
                for each (_local_3 in _falseReferencers)
                {
                    if (_local_3 != null)
                    {
                        _local_3._falseNext = _trueNext;
                    };
                };
                trueNext = (falseNext = null);
                _trueReferencers = (_falseReferencers = null);
            };
        }

        public function get falseNext():Block
        {
            return (_falseNext);
        }

        public function getRefCount():int
        {
            return (((_trueReferencers == null) ? 0 : _trueReferencers.length) + ((_falseReferencers == null) ? 0 : _falseReferencers.length));
        }

        public function set lastIsExit(_arg_1:Boolean):void
        {
            _lastIsExit = _arg_1;
        }


    }
}//package r1.deval.rt

