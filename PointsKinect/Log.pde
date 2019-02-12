class Log {
  private PrintWriter output;
  private String path=sketchPath();
  private String fileName;
  public int id=1;
 
  Log(String pth,String fileName, boolean overwrite, boolean create) {
    path = path+pth;
    this.fileName=fileName;
    if (exist(this.fileName) && !overwrite) {
      rename();
      if (create) {output= createWriter(path+this.fileName);}
    }
    else {
      if (create) {output= createWriter(path+this.fileName);}
    }
  }
 
  private String[] listFileNames(String dir) {
    File file = new File(dir);
    if (file.isDirectory()) {
      String names[] = file.list();
      return names;
    } 
    else {
      return null;
    }
  }
 
  private boolean exist(String fileName) {
    String[] filenames = listFileNames(path);
    for (int x=0; x<=filenames.length-1;x++) {
      if (fileName.equals(filenames[x])) {
        return true;
      }
    }
    return false;
  }
  
  private void rename() {
    String newName=(split(fileName, ".")[0]+str(id)+"."+split(fileName, ".")[1]);
    if (exist(newName)) {
      id++;
      rename();
    }
    else {
      fileName=newName;
      return;
    }
  }
  
  public void close() {
    output.flush();
    output.close();
  }
 
  public void write(String data) {
    output.println(data);
  }
  
  public String getName(){
     return fileName;
  }
  
}