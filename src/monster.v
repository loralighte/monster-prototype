import os
import io 
import loralighte.filereader as vfr

fn main(){
	monsterfile := vfr.read_lines("MonsterFile")
	mut chars := []string{}
	for i in monsterfile{
		mut str := []string{}
		for char in i{
			if rune(char).str() != " "{
				str << rune(char).str()
			}
		}
		chars << str
	}
	mut tags := []string{}
	mut files := []string{}
	mut option := ""
	for i in chars{
		if i != ";" && i != ":"{
			option += i
		} else if i == ":" {
			tags << option
			option = ""
		} else if i == ";"{
			files << option
			option = ""
		}
	}
	mut tag_output := []string{}
	mut open_files := []string{}
	for i in files {
		file_contents := vfr.read_lines(i) 
		mut html := ""
		for line in file_contents {
			mut line_cleared := ""
			mut pos := -1
			for char in line {
				pos += 1
				if rune(char).str() != " "{
					line_cleared += rune(char).str()
				} else {
					if rune(line[pos+1]).str() != " " && rune(line[pos+1]).str() != "<" {
						line_cleared += rune(char).str()
					}
				}
			}
			html += line_cleared
		}
		open_files << html
	}
	for i in open_files{
		tag_output << i
	}
	input := os.args[1]
	input_file := vfr.read_lines(input)
	output := os.args[2]
	mut data_to_write := []byte{}
	for i in input_file{
		mut tag := ""
		for char in i {
			if rune(char).str() != " " {
				tag += rune(char).str()
			}
		}
		monster_call := rune(tag[1]).str()
		if monster_call == "!" {
			mut calls := ""
			for char in tag {
				mut c := rune(char).str()
				if c != "<" && c != "!" && c != ">"{
					calls += c
				}
			}
			mut pos := -1
			for item in tags {
				pos += 1
				if calls == item {
					for char in tag_output[pos] {
						if rune(char).str() != "\n"{
							data_to_write << char
						}
					}
				}
			}
		} else {
			for char in tag {
				data_to_write << char
			}
		}
	}
	export := os.open_file(output, "w") ?
	mut export_data := io.new_multi_writer(export)
	export_data.write(data_to_write) ?
}