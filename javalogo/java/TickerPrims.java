import java.util.Timer;
import java.util.TimerTask;

class TickerPrims extends Primitives {

  static String[] primlist={"startticker", "1", "stopticker", "0"};


  public String[] primlist(){return primlist;}

  public Object dispatch(int offset, Object[] args, LContext lc){
    switch(offset){
    case 0: return prim_startticker(args[0], lc);
    case 1: return prim_stopticker(lc);
    }
    return null;
  }

  Timer timer;

  Object prim_startticker(Object arg1, LContext lc){
    int millis = Logo.anInt(arg1, lc);
    timer = new Timer();
    timer.scheduleAtFixedRate(new TickTask(lc), 1000, millis);
    return null;
  }


  Object prim_stopticker(LContext lc){
    timer.cancel();
    return null;
  }

}

class TickTask extends TimerTask {

  LogoCommandRunner runticktask;
  LContext lc;

  TickTask(LContext lc){
    super();
    runticktask = new LogoCommandRunner("ticktask", lc);
    this.lc = lc;
    }

  public void run() {
    if(lc.thread != null) return;
    runticktask.context.inticker = true;
    runticktask.run();
    runticktask.context.inticker = false;
  }

}

