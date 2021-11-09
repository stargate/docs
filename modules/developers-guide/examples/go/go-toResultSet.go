result := response.GetResultSet()

var i, j int
for i = 0; i < 2; i++ {
  valueToPrint := ""
  for j = 0; j < 2; j++ {
    value, err := client.ToString(result.Rows[i].Values[j])
    if err != nil {
      fmt.Printf("error getting value %v", err)
      os.Exit(1)
    }
    valueToPrint += " "
    valueToPrint += value
  }
  fmt.Printf("%v \n", valueToPrint)
}
}
