import React from "react";
import {Puzzle,LineIndex} from '../utils/types';
import {TouchableOpacity, ScrollView, StyleSheet, Text } from 'react-native';
type CodeSnippetsProps = {
    puzzle:Puzzle,
    lineIndex : LineIndex,
    onLineSelect: (index:number)=> void
}

export default function CodeSnippets({ puzzle, lineIndex, onLineSelect }: CodeSnippetsProps){
    const lines = puzzle.buggy_code.split('\n');
    return(
        <ScrollView style = {styles.screen}>
            {lines.map((line,index)=>(
                <TouchableOpacity key={index.toString()} onPress={()=>onLineSelect(index)} style={[styles.row, index === lineIndex && styles.selectedRow]}>
                    <Text style={styles.rowText}>{line}</Text>
                </TouchableOpacity>
            ))}
        </ScrollView>
    )
        

}
const styles = StyleSheet.create({
  screen: {
    marginTop: 30,
  },
  row: {
    margin: 15,
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    paddingHorizontal: 2,
  },
  rowText: {
    fontSize: 18,
    fontFamily: "Courier New"
  },
  selectedRow: {
    backgroundColor: "#a1a8d2"
  }
});