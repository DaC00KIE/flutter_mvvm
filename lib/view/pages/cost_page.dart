part of 'pages.dart';

class CostPage extends StatefulWidget {
  const CostPage({super.key});

  @override
  State<CostPage> createState() => _CostPageState();
}

class _CostPageState extends State<CostPage> {
  HomeViewModel homeViewmodel = HomeViewModel();

  @override
  void initState() {
    homeViewmodel.getProvinceList();
    super.initState();
  }

  dynamic originProvince, destinationProvince;
  dynamic originCity, destinationCity;
  dynamic weight;

  List<String> services = ['jne', 'pos', 'tiki'];
  dynamic selectedService = "jne";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Calculate Cost"),
          centerTitle: true,
        ),
        body: ChangeNotifierProvider<HomeViewModel>(
          create: (BuildContext context) => homeViewmodel,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                Flexible(
                    flex: 1,
                    child: Card(
                      color: Colors.white,
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: DropdownButton<String>(
                                      value: selectedService,
                                      hint: Text('Select service'),
                                      isExpanded: true,
                                      icon: Icon(Icons.arrow_drop_down),
                                      iconSize: 30,
                                      elevation: 2,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                      items: services
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedService =
                                              newValue; // Update the selected value
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        labelText: 'Weight (Kg)',
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          weight = double.tryParse(value);
                                        });
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),

                            SizedBox(height: 8),

                            // ORIGIN
                            Align(
                              alignment: Alignment
                                  .centerLeft, // Aligns text to the left
                              child: Text(
                                "Origin",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ), // Adjust styling as needed
                              ),
                            ),
                            Row(
                              children: [
                                //dropdown list provinsi
                                Expanded(
                                  child: Consumer<HomeViewModel>(
                                      builder: (context, value, _) {
                                    switch (value.provinceList.status) {
                                      case Status.loading:
                                        return Align(
                                          alignment: Alignment.center,
                                          child: CircularProgressIndicator(),
                                        );
                                      case Status.error:
                                        return Align(
                                          alignment: Alignment.center,
                                          child: Text(value.provinceList.message
                                              .toString()),
                                        );
                                      case Status.completed:
                                        return DropdownButton(
                                            isExpanded: true,
                                            value: originProvince,
                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize: 30,
                                            elevation: 2,
                                            hint: Text('Pilih provinsi'),
                                            style:
                                                TextStyle(color: Colors.black),
                                            items: value.provinceList.data!.map<
                                                    DropdownMenuItem<Province>>(
                                                (Province value) {
                                              return DropdownMenuItem(
                                                value: value,
                                                child: Text(
                                                    value.province.toString()),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                // selectedDataProvince = newValue;
                                                originProvince = newValue;
                                                originCity = null;
                                                homeViewmodel.getOriginList(
                                                    originProvince.provinceId);
                                              });
                                            });
                                      default:
                                    }
                                    return Container();
                                  }),
                                ), //dropdown list provinsi

                                SizedBox(width: 16),

                                Expanded(
                                  child: Consumer<HomeViewModel>(
                                      builder: (context, value, _) {
                                    switch (value.originCityList.status) {
                                      case Status.loading:
                                        return Align(
                                          alignment: Alignment.topLeft,
                                          child: CircularProgressIndicator(),
                                        );
                                      case Status.error:
                                        return Align(
                                          alignment: Alignment.center,
                                          child: Text(value
                                              .originCityList.message
                                              .toString()),
                                        );
                                      case Status.completed:
                                        return DropdownButton(
                                            isExpanded: true,
                                            value: originCity,
                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize: 30,
                                            elevation: 2,
                                            hint: Text('Pilih kota'),
                                            style:
                                                TextStyle(color: Colors.black),
                                            items: value.originCityList.data!
                                                .map<DropdownMenuItem<City>>(
                                                    (City value) {
                                              return DropdownMenuItem(
                                                value: value,
                                                child: Text(
                                                    value.cityName.toString()),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                originCity = newValue;
                                              });
                                            });
                                      default:
                                    }
                                    return Container();
                                  }),
                                ), //dropdown list city
                              ],
                            ), // END OF ORIGIN

                            SizedBox(height: 8),

                            // Destination
                            Align(
                              alignment: Alignment
                                  .centerLeft, // Aligns text to the left
                              child: Text(
                                "Destination",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight
                                        .bold), // Adjust styling as needed
                              ),
                            ),
                            Row(
                              children: [
                                //dropdown list provinsi
                                Expanded(
                                  child: Consumer<HomeViewModel>(
                                      builder: (context, value, _) {
                                    switch (value.provinceList.status) {
                                      case Status.loading:
                                        return Align(
                                          alignment: Alignment.center,
                                          child: CircularProgressIndicator(),
                                        );
                                      case Status.error:
                                        return Align(
                                          alignment: Alignment.center,
                                          child: Text(value.provinceList.message
                                              .toString()),
                                        );
                                      case Status.completed:
                                        return DropdownButton(
                                            isExpanded: true,
                                            value: destinationProvince,
                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize: 30,
                                            elevation: 2,
                                            hint: Text('Pilih provinsi akhir'),
                                            style:
                                                TextStyle(color: Colors.black),
                                            items: value.provinceList.data!.map<
                                                    DropdownMenuItem<Province>>(
                                                (Province value) {
                                              return DropdownMenuItem(
                                                value: value,
                                                child: Text(
                                                    value.province.toString()),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                // selectedDataProvince = newValue;
                                                destinationProvince = newValue;
                                                destinationCity = null;
                                                homeViewmodel
                                                    .getDestinationList(
                                                        destinationProvince
                                                            .provinceId);
                                              });
                                            });
                                      default:
                                    }
                                    return Container();
                                  }),
                                ), //dropdown list provinsi

                                SizedBox(width: 16),

                                Expanded(
                                  child: Consumer<HomeViewModel>(
                                      builder: (context, value, _) {
                                    switch (value.destinationCityList.status) {
                                      case Status.loading:
                                        return Align(
                                          alignment: Alignment.topLeft,
                                          child: CircularProgressIndicator(),
                                        );
                                      case Status.error:
                                        return Align(
                                          alignment: Alignment.center,
                                          child: Text(value
                                              .destinationCityList.message
                                              .toString()),
                                        );
                                      case Status.completed:
                                        return DropdownButton(
                                            isExpanded: true,
                                            value: destinationCity,
                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize: 30,
                                            elevation: 2,
                                            hint: originCity == null
                                                ? const Text('Pilih Kota')
                                                : Text(originCity.cityName),
                                            style:
                                                TextStyle(color: Colors.black),
                                            items: value
                                                .destinationCityList.data!
                                                .map<DropdownMenuItem<City>>(
                                                    (City value) {
                                              return DropdownMenuItem(
                                                value: value,
                                                child: Text(
                                                    value.cityName.toString()),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                destinationCity = newValue;
                                              });
                                            });
                                      default:
                                    }
                                    return Container();
                                  }),
                                ), //dropdown list city
                              ],
                            ),
                            // END OF Destination
                            SizedBox(height: 16),

                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[600],
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 3,
                              ),
                              onPressed: () {
                                if (validateInput()) {
                                  homeViewmodel.calculateServiceCost(
                                      origin: originCity.cityId.toString(),
                                      destination:
                                          destinationCity.cityId.toString(),
                                      weight: weight.toInt(),
                                      service: selectedService);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Please fill in all required fields!',
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: const Text(
                                "Hitung Estimasi Harga",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),

                            SizedBox(height: 16),

                            Expanded(
                              child: Consumer<HomeViewModel>(
                                  builder: (context, viewModel, child) {
                                final serviceCostsState = viewModel.serviceCost;

                                if (serviceCostsState.status ==
                                    Status.loading) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (serviceCostsState.status ==
                                    Status.completed) {
                                  final service = serviceCostsState.data;

                                  if (service!.costs != null) {
                                    return ListView(
                                      children: [
                                        ...service.costs?.map((costItem) {
                                              final cost =
                                                  costItem.cost?.isNotEmpty ==
                                                          true
                                                      ? costItem.cost![0]
                                                      : null;

                                              return Card(
                                                margin: EdgeInsets.all(8),
                                                color: Colors.white,
                                                elevation: 5,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      // Image on the left
                                                      Icon(
                                                        Icons
                                                            .local_shipping, // Truck icon
                                                        size: 50,
                                                        color: Colors
                                                            .blue, // You can adjust the color of the icon
                                                      ),
                                                      SizedBox(
                                                          width:
                                                              16), // Space between image and text

                                                      // Column with text content
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            // NAME OF SERVICE
                                                            Text(
                                                              costItem.service ??
                                                                  "Service Name",
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            SizedBox(height: 8),

                                                            // DESCRIPTION
                                                            Text(
                                                              costItem.description ??
                                                                  "No description",
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                                color: Colors
                                                                    .grey[700],
                                                              ),
                                                            ),
                                                            SizedBox(height: 8),

                                                            // COST
                                                            if (cost != null)
                                                              Text(
                                                                "Harga: Rp ${cost.value}",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                ),
                                                              ),

                                                            // ESTIMATED DELIVERY TIME (ETD)
                                                            if (cost != null)
                                                              Text(
                                                                "Estimated Delivery: ${cost.etd?.isNotEmpty == true ? '${cost.etd} days' : 'N/A'}",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .green,
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }).toList() ??
                                            [],
                                      ],
                                    );
                                  } else {
                                    return const Text("No Service Available");
                                  }
                                } else if (serviceCostsState.status ==
                                    Status.error) {
                                  return Text(
                                      "Error: ${serviceCostsState.message}");
                                } else {
                                  return const Text(
                                      "Press the button to calculate service cost.");
                                }
                              }),
                            )
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ));
  }

  bool validateInput() {
    return originCity != null &&
        destinationCity != null &&
        weight != null &&
        selectedService != null;
  }
}
