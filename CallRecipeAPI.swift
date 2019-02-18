//
//  CallRecipeAPI.swift
//  SousChef
//
//  Created by Louis Trapani on 4/22/18.
//  Copyright © 2018 trapani. All rights reserved.
//

import Foundation


class CallRecipeAPI {

    //yummly
    let yummlyEndpoint = "http://api.yummly.com/v1/api/recipes?_app_id=9fa276e4&_app_key=9be5f69faaed205574f31c80aa948274"
    var ingredientsString = "&q="
    var urlString = ""
    var responseData: Data?
    
    var xmlParser = XMLParser()
    var itemArray:[String] = []
    
    init(selectedIngredients:[String]) {
        urlString += yummlyEndpoint + ingredientsString + selectedIngredients[0]
        for i in 1...selectedIngredients.count {
            urlString += "+\(selectedIngredients[i])"
        }
        loadData()
    }
    
    func loadData() {
        let session = URLSession.shared
        let task = session.dataTask(with: URL(string:urlString)!) { (data, response, error) in
            //handle response
            print("received data")
            //cast to HTTP URLResponse obj to get status code, etc
            let httpResponse = response as! HTTPURLResponse
            print("response: \(httpResponse)")
            print("status code: \(httpResponse.statusCode)")
            print("header: \(httpResponse.allHeaderFields)")
            
            //convert binary adata to a string
            let string = String(data: data!, encoding: String.Encoding(rawValue:String.Encoding.ascii.rawValue)) //conversion
            print("Converted value= \(String(describing: string))")
            self.responseData = data
            
            DispatchQueue.main.async(execute: {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                //self.spinner.stopAnimating()
                //self.parseData()
            })
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        //spinner.startAnimating()
        //start task
        task.resume()
        
    } //loadData


    func parseData() {
        print("parseData: \(String(describing: responseData))")
        let string = String(data: responseData!, encoding: String.Encoding(rawValue:String.Encoding.ascii.rawValue)) //conversion
        //textView.text = string
        print("THIS IS THE PRINT: \(string)")

        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let fileURL = dir!.appendingPathComponent("data.xml")

        //try to write the file
        do {
            try string?.write(to: fileURL, atomically: true, encoding: .utf8)

            //            //can only do this for pList
            //            let dict = NSDictionary.init(contentsOf: fileURL)
            //            print("here it is as a dictionary: \(String(describing: dict))")
        } catch {
            print("Problem writing to disk!")
        }

        // start the parsing
        xmlParser = XMLParser(data: responseData!)
        xmlParser.delegate = self
        xmlParser.shouldResolveExternalEntities = false
        xmlParser.shouldProcessNamespaces = false
        xmlParser.shouldReportNamespacePrefixes = false

        if !xmlParser.parse() {
            print("Error in parse method: \(String(describing: xmlParser.parserError)) line number: \(xmlParser.lineNumber)")
        }

    }//parse data

    //MARK:-XMLParserDelegate method
    func parserDidStartDocument(_ parser: XMLParser) {
        print("parser started document")
    }

    func parserDidEndDocument(_ parser: XMLParser) {
        print("parser ended document")
        print("itemArray count=\(itemArray.count)")
        print("itemArray = \(itemArray)")
    }

    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("parser error: \(parseError)")
    }

    //called at the start of every tag
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        print("started element: \(elementName)")
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        print("found characters: \(string)")
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        print("ended element: \(elementName)")
        if elementName == "item" {
            itemArray.append(elementName)
        }
}
