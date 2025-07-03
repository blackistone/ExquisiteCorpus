// add depth and height

final static int sampleCount = 14;

Table table;
float[] ratio;
int[] z;
int[] y;
String[] IDs;
int c = 0;

Table outTable;

void setup() {

  table = loadTable("metrics.csv", "header");
  ratio = new float[sampleCount];
  IDs  = new String[sampleCount];
  z = new int[sampleCount];
  y = new int[sampleCount];

  outTable = new Table();
  outTable.addColumn("sample1");
  outTable.addColumn("sample2");
  outTable.addColumn("ratio");
  outTable.addColumn("z");
  outTable.addColumn("y");
  

  for (TableRow row : table.rows()) {
    IDs[c] = row.getString("sample");
    ratio[c] = row.getFloat("heightRatio");
    z[c] = row.getInt("z-depth");
    y[c] = row.getInt("y-height");
    println(IDs[c], ratio[c]);
    c++;
  }

  for (int i = 0; i<IDs.length/2; i++) {
    for (int j = IDs.length/2; j<IDs.length; j++) {
      
        TableRow newRow = outTable.addRow();
        newRow.setString("sample1", IDs[i]);
        newRow.setString("sample2", IDs[j]);
        newRow.setFloat("ratio", (ratio[i]+ratio[j])/2);
        newRow.setInt("z", (z[i]+z[j])/2);
        newRow.setInt("y", (y[i]+y[j])/2);
        
    }
  }
  outTable.sort("ratio");

  saveTable(outTable, "heightRatios.csv");
  exit();
}
