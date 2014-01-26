#!/usr/bin/ruby

class PriorityQueue
	def initialize(compare_proc=nil)
		@heap = []
		if compare_proc.nil?
			@compare_proc = lambda{|a,b| a > b}
		else
			@compare_proc = compare_proc
		end
	end

	private
	def swap(a, b)
		@heap[a],@heap[b] = @heap[b],@heap[a]
	end

	public
	def enqueue(data)
		# 末尾に格納
		i = @heap.length
		@heap[i] = data

		while i > 0
			# 親ノードの場所を特定
			parent = (i - 1) / 2

			# 親の方が小さいor等しければ終了
			break if !@compare_proc.call(@heap[parent], @heap[i])

			# 子の方が大きいので入れ替え
			swap(parent, i)

			# 次の処理対象ノードは親になるので、iを更新
			i = parent
		end
	end

	def dequeue
		# 返すデータのコピー
		data = @heap[0]

		# 末尾のデータを先頭に移す
		@heap[0] = @heap.pop

		parent = 0
		while parent * 2 + 1 < @heap.length
			# 子を比較し、親をどちらと入れ替えるか判定
			a = parent * 2 + 1
			b = parent * 2 + 2
			child = nil
			if b < @heap.length && @compare_proc.call(@heap[a], @heap[b])
				child = b
			else
				child = a
			end

			# 上で判定した子と親を比較し、親が小さければ終了
			break if !@compare_proc.call(@heap[parent], @heap[child])

			# 親の方が大きいので子と入れ替え
			swap(parent, child)

			# 次の処理は入れ替えた子を親として動作
			parent = child
		end

		data
	end

	def first
		@heap.first
	end

	def print
		puts @heap.join(' ')
	end
end

