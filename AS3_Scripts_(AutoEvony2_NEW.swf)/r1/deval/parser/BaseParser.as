// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//r1.deval.parser.BaseParser

package r1.deval.parser
{
    import r1.deval.rt.EndBlock;
    import r1.deval.rt.Block;
    import r1.deval.rt.FunctionDef;
    import r1.deval.rt.IExpr;
    import r1.deval.rt.ForInPrologue;
    import r1.deval.rt.ForInCond;
    import r1.deval.rt.UnaryStmt;
    import r1.deval.rt.ImportStmt;
    import r1.deval.rt.ExprList;
    import r1.deval.rt.*;

    public class BaseParser extends ExprParser 
    {

        public static var debugDump:Boolean = false;

        private var functionList:Array;
        private var functionExitBlock:EndBlock = null;
        private var curBlock:Block;
        private var switchStack:Array;
        private var forCount:int = 0;
        private var doWhileCount:int = 0;
        private var whileCount:int = 0;
        private var forInCount:int = 0;
        private var anonLabelCount:int = 0;
        private var labelStack:Array;
        private var blockStack:Array = [];


        private static function dumpProgram(_arg_1:String, _arg_2:Block, _arg_3:Array):void
        {
            var _local_5:FunctionDef;
            trace(_arg_1);
            var _local_4:Object = {};
            for each (_local_5 in _arg_3)
            {
                _local_5.dump(_local_4);
            };
            _arg_2.dump(_local_4);
        }

        private static function getIgnoredKeyword(_arg_1:int):String
        {
            switch (_arg_1)
            {
                case CLASS:
                    return ("class");
                case TRY:
                    return ("try");
                case CATCH:
                    return ("catch");
                case FINALLY:
                    return ("finally");
            };
            return ("");
        }


        public function addStmt(_arg_1:*, _arg_2:int):void
        {
            if (curBlock.lastIsExit)
            {
                reportError("msg.unreachable.code", "K51");
            };
            curBlock.addStmt(_arg_1, _arg_2);
        }

        protected function statementAsBlock(_arg_1:String=null, _arg_2:Boolean=false):Array
        {
            var _local_3:Block = new Block(_arg_1);
            newBlock(_local_3);
            statement(null, _arg_2);
            var _local_4:Array = [_local_3, curBlock];
            popBlock();
            return (_local_4);
        }

        private function curSwitch():Object
        {
            return (switchStack[(switchStack.length - 1)]);
        }

        protected function condition():IExpr
        {
            mustMatchToken(LP, "msg.no.paren.cond", "k51");
            var _local_1:IExpr = expression();
            mustMatchToken(RP, "msg.no.paren.after.cond", "k52");
            return (_local_1);
        }

        protected function enterLoop(_arg_1:Label, _arg_2:Block, _arg_3:Block, _arg_4:String=null):Label
        {
            if (_arg_1 == null)
            {
                _arg_1 = createLabel(_arg_4);
            };
            _arg_1.block = _arg_2;
            _arg_1.postfix = ((_arg_3 == null) ? _arg_2 : _arg_3);
            pushLabel(_arg_1);
            return (_arg_1);
        }

        public function lastIsExit(_arg_1:Block):Boolean
        {
            return ((!(_arg_1 == null)) && (_arg_1.lastIsExit));
        }

        private function popLabel():Label
        {
            return (labelStack.pop() as Label);
        }

        private function forStatement(_arg_1:int, _arg_2:Label):void
        {
            var _local_4:String;
            var _local_5:IExpr;
            var _local_3:Boolean;
            if (matchToken(NAME))
            {
                if (ts.getString() == "each")
                {
                    _local_3 = true;
                }
                else
                {
                    reportError("msg.no.paren.for", "K55");
                };
            };
            mustMatchToken(LP, "msg.no.paren.for", "k54");
            var _local_6:int = peekToken();
            if (_local_6 != SEMI)
            {
                if (_local_6 == VAR)
                {
                    consumeToken();
                    mustMatchToken(NAME, "msg.bad.var", "k55");
                    _local_4 = ts.getString();
                    if (peekToken() == IN)
                    {
                        consumeToken();
                        exprFactory.createVarExpr(_local_4);
                    }
                    else
                    {
                        variables(_local_4);
                        _local_4 = null;
                    };
                }
                else
                {
                    if (peekToken() == NAME)
                    {
                        _local_4 = ts.getString();
                        consumeToken();
                        if (peekToken() == IN)
                        {
                            consumeToken();
                        }
                        else
                        {
                            pushbackLookahead();
                            _local_4 = null;
                            statement(null, true);
                        };
                    }
                    else
                    {
                        statement(null, true);
                    };
                };
            };
            var _local_7:Block;
            if (_local_4)
            {
                _local_5 = expression();
            }
            else
            {
                mustMatchToken(SEMI, "msg.no.semi.for", "k56");
                _local_5 = ((peekToken() == SEMI) ? null : expression());
                mustMatchToken(SEMI, "msg.no.semi.for.cond", "k57");
                if (peekToken() != RP)
                {
                    _local_7 = (statementAsBlock(null, true)[0] as Block);
                };
            };
            mustMatchToken(RP, "msg.no.paren.for.ctrl", "k58");
            var _local_8:String = (((_local_3) ? "@for_each_" : ((_local_4) ? "@for_in_" : "@for_")) + forCount++);
            if (_local_4 == null)
            {
                whileStatement(_arg_1, _arg_2, _local_8, _local_5, ":for-body:", _local_7);
            }
            else
            {
                forInStatement(_arg_1, _arg_2, _local_8, _local_4, _local_5, _local_3, _local_7);
            };
        }

        private function doWhileStatement(stmtLabel:Label):void
        {
            var label:Label;
            var nextBlock:Block;
            var arr:Array = statementAsBlock(":do-while-body");
            var tempBlock:Block = (arr[0] as Block);
            curBlock.trueNext = tempBlock;
            if (!lastIsExit((arr[1] as Block).trueNext))
            {
                (arr[1] as Block).trueNext = tempBlock;
            };
            try
            {
                label = enterLoop(stmtLabel, tempBlock, null, "@do_while_");
                tempBlock.name = label.name;
                mustMatchToken(WHILE, "msg.no.while.do", "k53");
                tempBlock.setCond(condition(), ts.getLineno());
                nextBlock = new Block();
                if (!lastIsExit((arr[1] as Block).trueNext))
                {
                    (arr[1] as Block).falseNext = nextBlock;
                };
                popBlock();
                newBlock(nextBlock);
            }
            finally
            {
                exitLoop();
            };
        }

        override protected function parseFunction(_arg_1:Boolean=false):FunctionDef
        {
            var _local_2:String;
            var _local_3:int;
            if (!_arg_1)
            {
                _local_2 = checkAndConsumeToken(NAME, "msg.missing.function.name", "Kf1");
            };
            checkAndConsumeToken(LP, "msg.no.paren.parms", "Kf2");
            var _local_4:Array = [];
            while (true)
            {
                _local_3 = peekToken();
                if (_local_3 == RP)
                {
                    consumeToken();
                    break;
                };
                if (_local_3 == NAME)
                {
                    _local_4.push(ts.getString());
                    consumeToken();
                    _loop_1:
                    while (true)
                    {
                        switch (peekToken())
                        {
                            case COLON:
                            case DOT:
                            case NAME:
                                consumeToken();
                                break;
                            case COMMA:
                                consumeToken();
                            case RP:
                                break _loop_1;
                            default:
                                reportError("msg.no.paren.after.parms", "Kf3");
                        };
                    };
                };
            };
            _loop_2:
            while (true)
            {
                switch (peekToken())
                {
                    case COLON:
                    case DOT:
                    case NAME:
                        consumeToken();
                        break;
                    case LC:
                        consumeToken();
                        break _loop_2;
                    default:
                        reportError("msg.no.brace.body", "Kf4");
                };
            };
            var _local_5:Block = newBlock();
            var _local_6:EndBlock = (functionExitBlock = new EndBlock((("[/" + _local_2) + "]")));
            while (functionExitBlock != null)
            {
                statement();
            };
            var _local_7:Block = popBlockTo(_local_5);
            if (_local_7.getRefCount() > 0)
            {
                if (_local_7.trueNext == null)
                {
                    _local_7.trueNext = _local_6;
                };
                if (_local_7.falseNext == null)
                {
                    _local_7.falseNext = _local_6;
                };
            };
            return (new FunctionDef(_local_2, _local_4, _local_5, _local_6));
        }

        private function checkAndConsumeToken(_arg_1:int, _arg_2:String, _arg_3:String):String
        {
            if (peekToken() != _arg_1)
            {
                reportError(_arg_2, _arg_3);
            };
            var _local_4:String = ts.getString();
            consumeToken();
            return (_local_4);
        }

        private function get inSwitch():Boolean
        {
            return (switchStack.length > 0);
        }

        private function enterSwitch(_arg_1:Label, _arg_2:IExpr, _arg_3:int):void
        {
            checkAndConsumeToken(LC, "msg.no.brace.switch", "Ksw5");
            var _local_4:String = ("_switch_" + switchDepth);
            addStmt(exprFactory.createVarExpr(_local_4, _arg_2), 0);
            var _local_5:Block = curBlock;
            _local_5.trueNext = newBlock();
            if (_arg_1 == null)
            {
                _arg_1 = createLabel();
            };
            _arg_1.isSwitch = true;
            _arg_1.block = new Block();
            pushLabel(_arg_1);
            var _local_6:Object = {
                "switchVar":exprFactory.createAccessor(null, _local_4),
                "type":0,
                "branchHead":curBlock,
                "branchCondition":_local_5,
                "label":_arg_1
            };
            var _local_7:int = switchDepth;
            switchStack.push(_local_6);
            do 
            {
                statement();
            } while (switchDepth > _local_7);
        }

        protected function popBlock():Block
        {
            var _local_1:Block = (blockStack.pop() as Block);
            curBlock = (blockStack[(blockStack.length - 1)] as Block);
            return (_local_1);
        }

        private function getLabel(_arg_1:String):Label
        {
            var _local_2:Label = (labelStack[_arg_1] as Label);
            if (_local_2 == null)
            {
                reportError("msg.undef.label", "K53");
            };
            return (_local_2);
        }

        private function forInStatement(lineno:int, stmtLabel:Label, defaultLabelName:String, iterVar:String, coll:IExpr, isForEach:Boolean, increment:Block=null):void
        {
            var begin_end:Array;
            var begin:Block;
            var nextBlock:Block = new Block();
            var forInLoopId:int = forInCount++;
            var fip:ForInPrologue = new ForInPrologue(forInLoopId, iterVar, coll, isForEach, lineno);
            addStmt(fip, lineno);
            var tempBlock:Block = new Block();
            curBlock.trueNext = tempBlock;
            tempBlock.falseNext = nextBlock;
            var label:Label = enterLoop(stmtLabel, tempBlock, increment, defaultLabelName);
            tempBlock.name = label.name;
            try
            {
                begin_end = statementAsBlock(":for-body:");
                begin = (begin_end[0] as Block);
                if (increment != null)
                {
                    increment.trueNext = begin.trueNext;
                    begin.trueNext = increment;
                };
                tempBlock.setCond(new ForInCond(fip));
                tempBlock.trueNext = begin;
                tempBlock.falseNext = nextBlock;
                (begin_end[1] as Block).trueNext = tempBlock;
                popBlock();
                newBlock(nextBlock);
            }
            finally
            {
                exitLoop();
            };
        }

        private function whileStatement(lineno:int, stmtLabel:Label, defaultLabelName:String, cond:IExpr, bodyName:String=":while_body:", increment:Block=null):void
        {
            var begin_end:Array;
            var end:Block;
            var nextBlock:Block = new Block();
            var tempBlock:Block = new Block();
            curBlock.trueNext = tempBlock;
            tempBlock.setCond(cond, lineno);
            tempBlock.falseNext = nextBlock;
            var label:Label = enterLoop(stmtLabel, tempBlock, increment, defaultLabelName);
            tempBlock.name = label.name;
            try
            {
                begin_end = statementAsBlock(bodyName);
                end = (begin_end[1] as Block);
                if (((!(increment == null)) && (!(end.lastIsExit))))
                {
                    increment.trueNext = end.trueNext;
                    end.trueNext = increment;
                    end = increment;
                };
                tempBlock.trueNext = (begin_end[0] as Block);
                if (!end.lastIsExit)
                {
                    end.trueNext = tempBlock;
                };
                popBlock();
                newBlock(nextBlock);
            }
            finally
            {
                exitLoop();
            };
        }

        private function matchJumpLabelName():Label
        {
            if (peekTokenOrEOL() != NAME)
            {
                return (null);
            };
            consumeToken();
            return (getLabel(ts.getString()));
        }

        protected function newBlock(_arg_1:*=null):Block
        {
            if (_arg_1 == null)
            {
                _arg_1 = new Block();
            }
            else
            {
                if ((_arg_1 is String))
                {
                    _arg_1 = new Block(String(_arg_1));
                };
            };
            blockStack.push((curBlock = (_arg_1 as Block)));
            return (curBlock);
        }

        override protected function initParser(_arg_1:String):void
        {
            super.initParser(_arg_1);
            labelStack = [];
            switchStack = [];
            functionList = [];
        }

        private function breakContinueStatement(_arg_1:Boolean):void
        {
            curBlock.lastIsExit = true;
            var _local_2:Label = matchJumpLabelName();
            if (_local_2 == null)
            {
                _local_2 = peekLabel();
            };
            if (_local_2.isSwitch)
            {
                if (!_arg_1)
                {
                    reportError("msg.bad.continue", "Ksw");
                };
                curBlock.trueNext = _local_2.block;
            }
            else
            {
                curBlock.trueNext = ((_arg_1) ? _local_2.block.falseNext : _local_2.postfix);
            };
        }

        public function parseProgram(_arg_1:String):Object
        {
            var _local_3:FunctionDef;
            initParser(_arg_1);
            newBlock(":Main:");
            var _local_2:Block = curBlock;
            while (peekToken() != EOF)
            {
                statement();
            };
            if (curBlock.trueNext == null)
            {
                curBlock.trueNext = EndBlock.EXIT;
            };
            popBlock();
            if (debugDump)
            {
                dumpProgram("===== Pre-optimization =====", _local_2, functionList);
            };
            _local_2.optimize();
            for each (_local_3 in functionList)
            {
                _local_3.optimize();
            };
            if (debugDump)
            {
                dumpProgram("\n===== Post-optimization =====", _local_2, functionList);
            };
            if (functionList.length == 0)
            {
                return (_local_2);
            };
            return ([_local_2, functionList]);
        }

        private function ifStatement(_arg_1:int, _arg_2:IExpr):void
        {
            curBlock.setCond(_arg_2, _arg_1);
            var _local_3:Block = new Block();
            var _local_4:Array = statementAsBlock(":if-part:");
            curBlock.trueNext = (_local_4[0] as Block);
            var _local_5:Block = (_local_4[1] as Block);
            if (!_local_5.lastIsExit)
            {
                _local_5.trueNext = _local_3;
            };
            if (matchToken(ELSE))
            {
                consumeToken();
                _local_4 = statementAsBlock(":else-part:");
                curBlock.falseNext = (_local_4[0] as Block);
                _local_5 = (_local_4[1] as Block);
                if (!_local_5.lastIsExit)
                {
                    _local_5.trueNext = _local_3;
                };
            }
            else
            {
                curBlock.falseNext = _local_3;
            };
            popBlock();
            newBlock(_local_3);
        }

        private function switchEvent(_arg_1:int, _arg_2:IExpr=null):void
        {
            var _local_9:Label;
            var _local_3:int = ts.getLineno();
            var _local_4:Object = curSwitch();
            var _local_5:Block = (_local_4.branchCondition as Block);
            var _local_6:Block = (_local_4.branchHead as Block);
            var _local_7:int = (_local_4.type as int);
            _local_4.type = _arg_1;
            if (_arg_2 != null)
            {
                _arg_2 = exprFactory.createEqRelExpr((_local_4.switchVar as IExpr), _arg_2, EQ);
            };
            if (_local_7 == 0)
            {
                if (!_local_6.isEmpty())
                {
                    reportError("msg.unreachable.stmts.in.switch", "Ksw6");
                };
                if (_arg_1 == CASE)
                {
                    _local_5.setCond(_arg_2, _local_3);
                }
                else
                {
                    _local_4.defaultBlockHead = _local_6;
                };
                return;
            };
            var _local_8:Block = popBlockTo(_local_6);
            if (_local_7 == DEFAULT)
            {
                _local_4.defaultBlockTail = _local_8;
            };
            if (_arg_1 == RC)
            {
                _local_9 = popLabel();
                if (!_local_8.lastIsExit)
                {
                    _local_8.trueNext = _local_9.block;
                };
                _local_6 = (_local_4.defaultBlockHead as Block);
                if (_local_6 != null)
                {
                    _local_8 = (_local_4.defaultBlockTail as Block);
                    _local_5.falseNext = _local_6;
                };
                switchStack.pop();
                newBlock(_local_9.block);
                return;
            };
            _local_4.branchHead = newBlock();
            if (!_local_8.lastIsExit)
            {
                _local_8.trueNext = curBlock;
            };
            if (_arg_1 == DEFAULT)
            {
                _local_4.defaultBlockHead = curBlock;
            }
            else
            {
                if (_arg_1 == CASE)
                {
                    if (_local_5.getCond() != null)
                    {
                        _local_5.falseNext = new Block();
                        _local_5 = _local_5.falseNext;
                        _local_5.falseNext = peekLabel().block;
                        _local_4.branchCondition = _local_5;
                    };
                    _local_5.setCond(_arg_2, _local_3);
                    _local_5.trueNext = curBlock;
                };
            };
        }

        protected function popBlockTo(_arg_1:Block):Block
        {
            var _local_2:Block = popBlock();
            var _local_3:int = blockStack.indexOf(_arg_1);
            if (_local_3 >= 0)
            {
                blockStack.length = _local_3;
            };
            curBlock = (blockStack[(blockStack.length - 1)] as Block);
            return (_local_2);
        }

        private function createLabel(_arg_1:String=null):Label
        {
            if (_arg_1 == null)
            {
                _arg_1 = "@_";
            };
            return (new Label((_arg_1 + anonLabelCount++)));
        }

        private function peekLabel():Label
        {
            if (labelStack.length == 0)
            {
                reportError("msg.bad.break.continue", "K56");
            };
            return (labelStack[(labelStack.length - 1)] as Label);
        }

        protected function exitLoop():void
        {
            popLabel();
        }

        private function statements():void
        {
            var _local_1:int;
            while (((!((_local_1 = peekToken()) == EOF)) && (!(_local_1 == RC))))
            {
                statement();
            };
        }

        private function get switchDepth():int
        {
            return (switchStack.length);
        }

        private function defaultNamespaceStatement(_arg_1:int):void
        {
            if (!((matchToken(NAME)) && (ts.getString() == "xml")))
            {
                reportError("msg.bad.namespace", "K57");
            };
            if (!((matchToken(NAME)) && (ts.getString() == "namespace")))
            {
                reportError("msg.bad.namespace", "K58");
            };
            if (!matchToken(ASSIGN))
            {
                reportError("msg.bad.namespace", "K59");
            };
            addStmt(new UnaryStmt(DEFAULT_NS, expression(), _arg_1), _arg_1);
        }

        private function statement(_arg_1:Label=null, _arg_2:Boolean=false):void
        {
            var _local_3:Block;
            var _local_4:IExpr;
            var _local_5:Label;
            var _local_6:Array;
            var _local_9:String;
            var _local_10:Boolean;
            var _local_11:int;
            var _local_7:int = ts.getLineno();
            var _local_8:int = peekToken();
            switch (_local_8)
            {
                case IF:
                    consumeToken();
                    ifStatement(_local_7, condition());
                    return;
                case SWITCH:
                    consumeToken();
                    enterSwitch(_arg_1, condition(), _local_7);
                    break;
                case CASE:
                    consumeToken();
                    if (!inSwitch)
                    {
                        reportError("msg.misplaced.case", "Ksw1");
                    };
                    _local_4 = expression();
                    checkAndConsumeToken(COLON, "msg.case.no.colon", "Ksw2");
                    switchEvent(CASE, _local_4);
                    return;
                case DEFAULT:
                    consumeToken();
                    if (peekToken() == COLON)
                    {
                        checkAndConsumeToken(COLON, "msg.case.no.colon", "Ksw3");
                        switchEvent(DEFAULT);
                        return;
                    };
                    defaultNamespaceStatement(_local_7);
                    break;
                case RC:
                    if (((!(inSwitch)) && (functionExitBlock == null)))
                    {
                        reportError("msg.misplaced.right.brace", "Krc");
                    };
                    consumeToken();
                    if (inSwitch)
                    {
                        switchEvent(RC);
                    }
                    else
                    {
                        functionExitBlock = null;
                    };
                    return;
                case BREAK:
                case CONTINUE:
                    consumeToken();
                    breakContinueStatement((_local_8 == BREAK));
                    break;
                case THROW:
                    consumeToken();
                    curBlock.lastIsExit = true;
                    addStmt(new UnaryStmt(THROW, expression(), _local_7), _local_7);
                    break;
                case WHILE:
                    consumeToken();
                    _local_4 = condition();
                    whileStatement(_local_7, _arg_1, ("@while_" + whileCount++), _local_4);
                    return;
                case DO:
                    consumeToken();
                    doWhileStatement(_arg_1);
                    return;
                case FOR:
                    consumeToken();
                    forStatement(ts.getLineno(), _arg_1);
                    return;
                case VAR:
                    consumeToken();
                    variables();
                    break;
                case RETURN:
                    consumeToken();
                    switch (peekTokenOrEOL())
                    {
                        case SEMI:
                            consumeToken();
                        case RC:
                        case EOF:
                        case EOL:
                        case ERROR:
                            break;
                        default:
                            addStmt(expression(), _local_7);
                    };
                    curBlock.trueNext = ((functionExitBlock != null) ? functionExitBlock : EndBlock.EXIT);
                    curBlock.lastIsExit = true;
                    break;
                case LC:
                    consumeToken();
                    statements();
                    mustMatchToken(RC, "msg.no.brace.block", "k65");
                    return;
                case ERROR:
                case SEMI:
                    consumeToken();
                    break;
                case IMPORT:
                    consumeToken();
                    readImports(_local_7);
                    break;
                case NAME:
                    _local_9 = ts.getString();
                    setCheckForLabel();
                    _local_4 = expression();
                    if ((_local_4 is Label))
                    {
                        if (_arg_1 == null)
                        {
                            _local_10 = true;
                            _arg_1 = (_local_4 as Label);
                        }
                        else
                        {
                            _local_10 = false;
                        };
                        statement(_arg_1);
                        break;
                    };
                    addStmt(_local_4, _local_7);
                    break;
                case FUNCTION:
                    consumeToken();
                    functionList.push(parseFunction());
                    break;
                case CLASS:
                    reportError("msg.class.not.supported", "K64");
                    break;
                case TRY:
                case CATCH:
                case FINALLY:
                    reportError("msg.reserved.id", "K54", getIgnoredKeyword(_local_8));
                    break;
                default:
                    addStmt(expression(), ts.getLineno());
            };
            if (!_arg_2)
            {
                _local_11 = peekFlaggedToken();
                switch ((_local_11 & CLEAR_TI_MASK))
                {
                    case SEMI:
                        consumeToken();
                    case ERROR:
                    case EOF:
                    case RC:
                        return;
                    default:
                        if ((_local_11 & TI_AFTER_EOL) == 0)
                        {
                            reportError("msg.no.semi.stmt", "K65");
                        };
                };
            };
        }

        private function readImports(_arg_1:int):void
        {
            var _local_3:String;
            var _local_4:int;
            var _local_2:Array = [];
            _loop_1:
            while (true)
            {
                _local_4 = peekFlaggedToken();
                switch ((_local_4 & CLEAR_TI_MASK))
                {
                    case NAME:
                        if (!_local_3)
                        {
                            _local_3 = ts.getString();
                        }
                        else
                        {
                            _local_3 = (_local_3 + ("." + ts.getString()));
                        };
                        consumeToken();
                        break;
                    case DOT:
                        consumeToken();
                        break;
                    case COMMA:
                        _local_2.push(_local_3);
                        _local_3 = null;
                        consumeToken();
                        break;
                    case SEMI:
                        consumeToken();
                    case ERROR:
                    case EOF:
                    case RC:
                        break _loop_1;
                    default:
                        if ((_local_4 & TI_AFTER_EOL) == 0)
                        {
                            reportError("msg.no.semi.stmt", "K66");
                        };
                        break _loop_1;
                };
            };
            _local_2.push(_local_3);
            addStmt(new ImportStmt(_local_2, _arg_1), _arg_1);
        }

        private function pushLabel(_arg_1:Label):void
        {
            if (labelStack[_arg_1.name] != null)
            {
                reportError("msg.dup.label", "K61");
            };
            labelStack.push(_arg_1);
            labelStack[_arg_1.name] = _arg_1;
        }

        private function variables(_arg_1:String=null):void
        {
            var _local_2:IExpr;
            var _local_4:*;
            var _local_5:*;
            var _local_3:int = ts.getLineno();
            do 
            {
                if (_arg_1 != null)
                {
                    _local_4 = _arg_1;
                }
                else
                {
                    mustMatchToken(NAME, "msg.bad.var", "k66");
                    _local_4 = ts.getString();
                };
                if (peekToken() == COLON)
                {
                    consumeToken();
                    mustMatchToken(NAME, "msg.bad.var", "k67");
                    consumeToken();
                };
                _local_5 = null;
                if (matchToken(ASSIGN))
                {
                    _local_5 = assignExpr();
                };
                _local_2 = exprFactory.createVarExpr(_local_4, _local_5, _local_2);
            } while (matchToken(COMMA));
            if ((_local_2 is ExprList))
            {
                _local_2 = (_local_2 as ExprList).reduce();
            };
            addStmt(_local_2, _local_3);
        }


    }
}//package r1.deval.parser

