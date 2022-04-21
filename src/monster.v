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
		open_files << vfr.read_lines(i)
	}
	for i in open_files{
		tag_output << i
	}
	output := os.args[1]
	mut data_to_write := []byte{}
	for i in tag_output{
		data_to_write << i.bytes()
	}
	export := os.open_file(output, "w") ?
	mut export_data := io.new_multi_writer(export)
	export_data.write(data_to_write) ?
}