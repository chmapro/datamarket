# File: semantic_consistency_check.py

import numpy as np
from sklearn.metrics.pairwise import cosine_similarity
from sentence_transformers import SentenceTransformer

# 初始化预训练模型
model = SentenceTransformer('all-MiniLM-L6-v2')

# 语义一致性检查函数
def semantic_consistency_check(input_text, reference_texts, threshold=0.8):
    input_vector = model.encode(input_text)
    reference_vectors = model.encode(reference_texts)

    similarities = cosine_similarity([input_vector], reference_vectors)[0]
    max_similarity = np.max(similarities)

    return max_similarity >= threshold, max_similarity

# 示例数据
input_text = "This is a new data entry that needs to be checked."
reference_texts = [
    "This is an existing data entry from the database.",
    "Completely unrelated text that should have low similarity.",
    "A data entry very similar to the new entry that needs checking."
]

# 执行语义一致性检查
is_consistent, similarity_score = semantic_consistency_check(input_text, reference_texts)

print(f"Semantic consistency is {'confirmed' if is_consistent else 'not confirmed'}, Similarity Score: {similarity_score:.4f}")
